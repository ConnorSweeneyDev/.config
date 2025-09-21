$Env:FZF_FILE_COMMAND = "fd --type f --strip-cwd-prefix --hidden --exclude .git --no-ignore"
$Env:FZF_FILE_OPTS = "--preview=`"bat --style=numbers --color=always {}`" --preview-window=border-rounded --preview-label=`" PREVIEW `" --border=rounded --border-label=`" FILES `" --tabstop=2 --color=16 --bind=ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"
$Env:FZF_DIRECTORY_COMMAND = "fd --type d --strip-cwd-prefix --hidden --exclude .git --no-ignore"
$Env:FZF_DIRECTORY_OPTS = "--preview=`"pwsh -NoProfile -Command Get-ChildItem -Force -LiteralPath '{}'`" --preview-window=border-rounded --preview-label=`" PREVIEW `" --border=rounded --border-label=`" DIRECTORIES `" --tabstop=2 --color=16 --bind=ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"

function msvc # Sets up the environment for MSVC command line tools - Usage: msvc [-i]
{
  param([Alias("i")][switch]$Info = $false)

  $architecture = $env:VSCMD_ARG_HOST_ARCH
  $vsPath = $env:VSINSTALLDIR
  $toolsetVersion = $env:VCToolsVersion
  $sdkVersion = $env:WindowsSDKVersion
  if ($Info)
  {
    if (-not $architecture -or -not $vsPath -or -not $toolsetVersion -or -not $sdkVersion)
    {
      Write-Host "MSVC environment not configured" -ForegroundColor Red
      return
    }
    Write-Host "MSVC environment configured for $architecture" -ForegroundColor Green
    Write-Host "Visual Studio: $vsPath" -ForegroundColor Gray
    Write-Host "Toolset: $toolsetVersion" -ForegroundColor Gray
    Write-Host "Windows SDK: $sdkVersion" -ForegroundColor Gray
    return
  }
  if ($architecture -and $vsPath -and (Test-Path $vsPath) -and $toolsetVersion -and $sdkVersion)
  {
    Write-Host "MSVC environment already configured for $architecture" -ForegroundColor Yellow
    return
  }

  if (-not $env:ORIGINAL_PATH) { $env:ORIGINAL_PATH = $env:PATH }

  $architecture = switch ($env:PROCESSOR_ARCHITECTURE)
  {
    "AMD64" { "x64" }
    "x86"   { "x86" }
    "ARM64" { "arm64" }
    default { Write-Error "Unsupported architecture: $($env:PROCESSOR_ARCHITECTURE)"; return }
  }

  $vsPath = $null
  $vsWhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
  if (Test-Path $vsWhere)
  {
    try { $vsPath = & $vsWhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath 2>$null }
    catch { Write-Warning "vswhere.exe failed: $($_.Exception.Message)" }
  }
  if (-not $vsPath)
  {
    try
    {
      $vsKey = Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\SxS\VS7" -ErrorAction SilentlyContinue
      if ($vsKey)
      {
        $latestVS = $vsKey.PSObject.Properties | Where-Object { $_.Name -match "^\d+\.\d+$" } | Sort-Object Name -Descending | Select-Object -First 1
        if ($latestVS) { $vsPath = $latestVS.Value }
      }
    }
    catch { Write-Warning "Registry lookup failed: $($_.Exception.Message)" }
  }
  if (-not $vsPath -or -not (Test-Path $vsPath))
  {
    Write-Error "Visual Studio installation not found"
    return
  }
  $vsPath = $vsPath.TrimEnd('\')
  $vsVersion = Split-Path (Split-Path $vsPath) -Leaf

  $msvcPath = Join-Path $vsPath "VC\Tools\MSVC"
  $toolsetVersion = $null
  if (Test-Path $msvcPath)
  {
    try { $toolsetVersion = Get-ChildItem $msvcPath -ErrorAction SilentlyContinue | Sort-Object Name -Descending | Select-Object -First 1 -ExpandProperty Name }
    catch { Write-Warning "Failed to find MSVC toolset: $($_.Exception.Message)" }
  }
  if (-not $toolsetVersion)
  {
    Write-Error "MSVC toolset not found"
    return
  }
  $toolsetVersion = $toolsetVersion.TrimEnd('\')

  $sdkRoot = $null
  $sdkVersion = $null
  try
  {
    $sdkKey = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Kits\Installed Roots" -ErrorAction SilentlyContinue
    if ($sdkKey -and $sdkKey.KitsRoot10)
    {
      $sdkRoot = $sdkKey.KitsRoot10
      $sdkIncludePath = Join-Path $sdkRoot "Include"
      if (Test-Path $sdkIncludePath) { $sdkVersion = Get-ChildItem $sdkIncludePath -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "^\d+\." } | Sort-Object Name -Descending | Select-Object -First 1 -ExpandProperty Name }
    }
  }
  catch { Write-Warning "Windows SDK detection failed: $($_.Exception.Message)" }
  if (-not $sdkRoot -or -not $sdkVersion)
  {
    Write-Error "Windows SDK not found"
    return
  }
  $sdkVersion = $sdkVersion.TrimEnd('\')

  $msvcToolsPath = Join-Path $vsPath "VC\Tools\MSVC\$toolsetVersion"
  $pathCandidates = @(
    (Join-Path $msvcToolsPath "bin\Host$architecture\$architecture"),

    (Join-Path $vsPath "Common7\IDE"),
    (Join-Path $vsPath "Common7\Tools"),
    (Join-Path $vsPath "Common7\IDE\CommonExtensions\Microsoft\TestWindow"),
    (Join-Path $vsPath "Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer"),

    (Join-Path $vsPath "MSBuild\Current\Bin"),
    (Join-Path $vsPath "MSBuild\Current\Bin\amd64"),
    (Join-Path $vsPath "MSBuild\Current\bin\Roslyn"),

    (Join-Path $vsPath "Team Tools\Performance Tools"),
    (Join-Path $vsPath "Team Tools\Performance Tools\$architecture"),

    (Join-Path $sdkRoot "bin\$sdkVersion\$architecture"),
    (Join-Path $sdkRoot "bin\$architecture"),

    "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Shared\Common\VSPerfCollectionTools\vs$vsVersion",
    "${env:ProgramFiles(x86)}\Windows Kits\10\bin\$architecture",
    "${env:ProgramFiles(x86)}\Windows Kits\10\bin\$sdkVersion\$architecture"
  )
  $msvcIncludePath = Join-Path $msvcToolsPath "include"
  $sdkIncludePaths = @(
    "Include\$sdkVersion\ucrt",
    "Include\$sdkVersion\um",
    "Include\$sdkVersion\shared",
    "Include\$sdkVersion\winrt",
    "Include\$sdkVersion\cppwinrt"
  ) | ForEach-Object { Join-Path $sdkRoot $_ } | Where-Object { Test-Path $_ }
  $msvcLibPath = Join-Path $msvcToolsPath "lib\$architecture"
  $sdkLibPaths = @(
    "Lib\$sdkVersion\ucrt\$architecture",
    "Lib\$sdkVersion\um\$architecture"
  ) | ForEach-Object { Join-Path $sdkRoot $_ } | Where-Object { Test-Path $_ }

  $validPaths = $pathCandidates | Where-Object { Test-Path $_ }
  $originalPaths = $env:ORIGINAL_PATH -split ";" | Where-Object { $_ }
  $normalizedValidPaths = $validPaths | ForEach-Object { $_.TrimEnd('\') }
  $normalizedOriginalPaths = $originalPaths | ForEach-Object { $_.TrimEnd('\') }
  $cleanOriginalPaths = $normalizedOriginalPaths | Where-Object { $path = $_; -not ($normalizedValidPaths | Where-Object { $path -ieq $_ }) }
  $env:PATH = ($normalizedValidPaths + $cleanOriginalPaths) -join ";"

  $env:INCLUDE = (@($msvcIncludePath) + $sdkIncludePaths) -join ";"
  $env:LIB = (@($msvcLibPath) + $sdkLibPaths) -join ";"
  $env:LIBPATH = $msvcLibPath

  $env:Platform = $architecture
  $env:PreferredToolArchitecture = $architecture
  $env:VSCMD_ARG_HOST_ARCH = $architecture
  $env:VSCMD_ARG_TGT_ARCH = $architecture
  $env:VSINSTALLDIR = $vsPath
  $env:VCINSTALLDIR = Join-Path $vsPath "VC"
  $env:VCToolsVersion = $toolsetVersion

  $env:WindowsLibPath = Join-Path $sdkRoot "UnionMetadata\$sdkVersion"
  $env:WindowsSdkDir = $sdkRoot
  $env:WindowsSDKVersion = $sdkVersion
  $env:UniversalCRTSdkDir = $sdkRoot
  $env:UCRTVersion = $sdkVersion
}
msvc
