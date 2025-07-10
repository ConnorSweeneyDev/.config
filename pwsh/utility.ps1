function update # Keep the tab title and osc7 up to date
{
  $title = Split-Path -Leaf -Path (Get-Location)
  $Host.UI.RawUI.WindowTitle = $title
  $esc = [char]27
  $path = '/' + (Get-Location)
  $bel = [char]7
  $osc7 = "${esc}]7;file://$path${bel}"
  Write-Host -NoNewline "$osc7"
}
function prompt # Run update every prompt and use a custom prompt display
{
  update
  $esc = [char]27
  $cReset     = "${esc}[0m"
  $cPath      = "${esc}[38;2;10;122;202m"
  $cBranch    = "${esc}[38;2;197;134;192m"
  $cAdded     = "${esc}[38;2;106;153;85m"
  $cUntracked = "${esc}[38;2;170;170;170m"
  $cModified  = "${esc}[38;2;220;220;170m"
  $cRemoved   = "${esc}[38;2;244;71;71m"
  $cBracket   = "${esc}[38;2;120;120;120m"
  $cCommits   = "${esc}[38;2;255;175;0m"
  $isGit = git rev-parse --is-inside-work-tree
  if ($isGit)
  {
    $branch = git rev-parse --abbrev-ref HEAD
    $status = git status --porcelain
    $untrackedCount = 0
    $addedCount = 0
    $modifiedUnstagedCount = 0
    $removedUnstagedCount = 0
    $modifiedStagedCount = 0
    $removedStagedCount = 0
    $unpushedCommits = 0
    foreach ($line in $status)
    {
      $first = $line.Substring(0, 1)
      $second = $line.Substring(1, 1)
      if ($first -eq '?' -and $second -eq '?') { $untrackedCount++ }
      elseif ($first -eq 'A') { $addedCount++ }
      elseif ($second -eq 'M') { $modifiedUnstagedCount++ }
      elseif ($second -eq 'D') { $removedUnstagedCount++ }
      elseif ($first -eq 'M' -or $first -eq 'R') { $modifiedStagedCount++ }
      elseif ($first -eq 'D') { $removedStagedCount++ }
    }
    $unstagedChanges = @()
    if ($untrackedCount -gt 0) { $unstagedChanges += "${cUntracked}?$untrackedCount${cReset}" }
    if ($modifiedUnstagedCount -gt 0) { $unstagedChanges += "${cModified}~$modifiedUnstagedCount${cReset}" }
    if ($removedUnstagedCount -gt 0) { $unstagedChanges += "${cRemoved}-$removedUnstagedCount${cReset}" }
    $stagedChanges = @()
    if ($addedCount -gt 0) { $stagedChanges += "$cAdded+$addedCount$cReset" }
    if ($modifiedStagedCount -gt 0) { $stagedChanges += "${cModified}~$modifiedStagedCount${cReset}" }
    if ($removedStagedCount -gt 0) { $stagedChanges += "${cRemoved}-$removedStagedCount${cReset}" }
    $status = @()
    $status += "${cBranch}$branch${cReset}"
    if ($unstagedChanges.Count -gt 0) { $status += "${cBracket}[${cReset}" + ($unstagedChanges -join " ") + "${cBracket}]${cReset}" }
    if ($stagedChanges.Count -gt 0) { $status += "${cBracket}{${cReset}" + ($stagedChanges -join " ") + "${cBracket}}${cReset}"}
    try {
      $commitCount = git rev-list --count origin/$branch..HEAD
      if ($commitCount -gt 0) { $unpushedCommits = $commitCount }
      else { $unpushedCommits = 0 }
    }
    catch { $unpushedCommits = 0 }
    $commits = @()
    if ($unpushedCommits -gt 0) { $commits += "${cCommits}^$unpushedCommits${cReset}" }
  }
  else { $status = "" }
  return "${cPath}$pwd${cReset} $status $commits`n${cPath}>${cReset} "
}

function d # Better rm - Usage: d <path1> <path2> ... <pathN>
{
  $paths = $args
  foreach ($path in $paths)
  {
    if (Test-Path $path) { Remove-Item $path -Recurse -Force }
    else { echo "Path does not exist: $path" }
  }
}
function fh # Searches your command history, sets your clipboard to the selected item - Usage: fh [<string>]
{
  $find = $args
  $Env:FZF_DEFAULT_OPTS = "--border=rounded --border-label=`" HISTORY `" --tabstop=2 --color=16"
  $selected = Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -like "*$find*"} | Sort-Object -Unique -Descending | fzf
  if (![string]::IsNullOrWhiteSpace($selected)) { Set-Clipboard $selected }
}

function fzf_files
{
  if ($args -eq "." -or $args.Count -eq 0) {}
  elseif ($args -eq "d") { cd D:\ }
  elseif ($args -eq "u") { cd $Env:USERPROFILE }
  elseif ($args -eq "c") { cd C:\ }
  else
  {
    echo "Invalid argument: $args"
    return
  }
  $Env:FZF_DEFAULT_COMMAND = $Env:FZF_FILE_COMMAND
  $Env:FZF_DEFAULT_OPTS = $Env:FZF_FILE_OPTS
  $Host.UI.RawUI.WindowTitle = "FZF"
  $selected = fzf
  return $selected
}
function fzf_directories
{
  if ($args -eq "." -or $args.Count -eq 0) {}
  elseif ($args -eq "d") { cd D:\ }
  elseif ($args -eq "u") { cd $Env:USERPROFILE }
  elseif ($args -eq "c") { cd C:\ }
  else
  {
    echo "Invalid argument: $args"
    return
  }
  $Env:FZF_DEFAULT_COMMAND = $Env:FZF_DIRECTORY_COMMAND
  $Env:FZF_DEFAULT_OPTS = $Env:FZF_DIRECTORY_OPTS
  $Host.UI.RawUI.WindowTitle = "FZF"
  $selected = fzf
  return $selected
}

function fi # Runs fzf searching files then cd's to the directory of the selected file - Usage: fzc [d | u | c]
{
  $selected = fzf_files @args
  if ([string]::IsNullOrWhiteSpace($selected))
  {
    cd C:\
    return
  }
  $parent = Split-Path -parent -path $selected
  cd $parent
}
function di # Runs fzf searching directories then cd's to the selected directory - Usage: dzc [d | u | c]
{
  $selected = fzf_directories @args
  if ([string]::IsNullOrWhiteSpace($selected))
  {
    cd C:\
    return
  }
  cd $selected
}
