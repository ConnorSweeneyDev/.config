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

  $path = Get-Location
  $gitDir = $null
  $branch = $null
  while ($path)
  {
    $gitPath = Join-Path $path '.git'
    if (Test-Path $gitPath)
    {
      if (Test-Path $gitPath -PathType Container)
      {
        $gitDir = $gitPath
        $headPath = Join-Path $gitPath 'HEAD'
      }
      else
      {
        $gitDirLine = Get-Content $gitPath | Select-Object -First 1
        $gitDir = $gitDirLine -replace 'gitdir: ', ''
        $headPath = Join-Path $gitDir 'HEAD'
      }
      if (Test-Path $headPath)
      {
        $branch = (Get-Content $headPath) -replace '^ref: refs/heads/', ''
        $branch = $branch -replace '^ref: refs/tags/', 'tag:'
        $branch = $branch -replace '^ref: refs/remotes/', 'remote:'
        if ($branch -match '^[a-f0-9]{40}$') { $branch = $branch.Substring(0, 7) }
        $rebaseDir = Join-Path $gitDir 'rebase-merge'
        $mergeHead = Join-Path $gitDir 'MERGE_HEAD'
        if (Test-Path $rebaseDir)
        {
          $headNameFile = Join-Path $rebaseDir 'head-name'
          if (Test-Path $headNameFile)
          {
            $rebaseBranch = (Get-Content $headNameFile) -replace '^refs/heads/', ''
            $branch = "rebase:$rebaseBranch"
          }
          else { $branch = "rebse:$branch" }
        }
        elseif (Test-Path $mergeHead) { $branch = "merge:$branch" }
        break
      }
    }
    $parent = Split-Path $path -Parent
    if ($parent -eq $path) { break }
    $path = $parent
  }

  $esc        = [char]27
  $cReset     = "${esc}[0m"
  $cPath      = "${esc}[38;2;10;122;202m"
  $cBranch    = "${esc}[38;2;197;134;192m"
  $cAdded     = "${esc}[38;2;106;153;85m"
  $cUntracked = "${esc}[38;2;170;170;170m"
  $cModified  = "${esc}[38;2;220;220;170m"
  $cRemoved   = "${esc}[38;2;244;71;71m"
  $cBracket   = "${esc}[38;2;120;120;120m"
  $cCommits   = "${esc}[38;2;255;175;0m"
  if ($branch)
  {
    $status       = git status --porcelain 2>$null
    $commitCount  = 0
    $headCommit   = $null
    $remoteCommit = $null
    $headRefPath  = Join-Path $gitDir "refs/heads/$branch"
    if (Test-Path $headRefPath) { $headCommit = Get-Content $headRefPath }
    $remoteRefPath = Join-Path $gitDir "refs/remotes/origin/$branch"
    if (Test-Path $remoteRefPath) { $remoteCommit = Get-Content $remoteRefPath }
    else
    {
      $packedRefsPath = Join-Path $gitDir "packed-refs"
      if (Test-Path $packedRefsPath)
      {
        $packedRefs = Get-Content $packedRefsPath
        foreach ($line in $packedRefs)
        {
          if ($line -match "^([a-f0-9]+) refs/remotes/origin/$branch$")
          {
            $remoteCommit = $matches[1]
            break
          }
        }
      }
    }
    if (-not $remoteCommit)
    {
      $mainRef = Join-Path $gitDir "refs/heads/main"
      $masterRef = Join-Path $gitDir "refs/heads/master"
      if (Test-Path $mainRef) { $remoteCommit = Get-Content $mainRef }
      elseif (Test-Path $masterRef) { $remoteCommit = Get-Content $masterRef }
    }
    if ($headCommit -and $remoteCommit -and $headCommit -ne $remoteCommit)
    {
      $commitCount = git rev-list --count "$remoteCommit..$headCommit" 2>$null
      if (-not $commitCount) { $commitCount = 0 }
    }

    $untrackedCount        = 0
    $addedCount            = 0
    $modifiedUnstagedCount = 0
    $removedUnstagedCount  = 0
    $modifiedStagedCount   = 0
    $removedStagedCount    = 0
    $unpushedCommits       = 0
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
    if ($commitCount -gt 0) { $unpushedCommits = $commitCount }
    else { $unpushedCommits = 0 }
    if ($unpushedCommits -gt 0) { $status += "${cCommits}^$unpushedCommits${cReset}" }
  }
  else { $status = "" }

  return "${cPath}$pwd${cReset} $status`n${cPath}>${cReset} "
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

function fzf_files # Utility macro for setting up fzf for file searching
{
  if ($args -eq "." -or $args.Count -eq 0) {}
  elseif ($args -eq "c") { cd C:\ }
  elseif ($args -eq "d") { cd D:\ }
  elseif ($args -eq "u") { cd $Env:USERPROFILE }
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
function fzf_directories # Utility macro for setting up fzf for directory searching
{
  if ($args -eq "." -or $args.Count -eq 0) {}
  elseif ($args -eq "c") { cd C:\ }
  elseif ($args -eq "d") { cd D:\ }
  elseif ($args -eq "u") { cd $Env:USERPROFILE }
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

function fi # Runs fzf searching files then cd's to the directory of the selected file - Usage: fi [d | u | c]
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
function di # Runs fzf searching directories then cd's to the selected directory - Usage: di [d | u | c]
{
  $selected = fzf_directories @args
  if ([string]::IsNullOrWhiteSpace($selected))
  {
    cd C:\
    return
  }
  cd $selected
}
