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
function fzc # Runs fzf searching files then cd's to the directory of the selected file - Usage: fzc [d | u | c]
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
  if (![string]::IsNullOrWhiteSpace($selected))
  {
    $parent = Split-Path -parent -path $selected
    cd $parent
  }
  else { cd C:\ }
}
function fze # Runs fzf searching files then opens the directory of the selected file in explorer - Usage: fze [d | u | c]
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
  if (![string]::IsNullOrWhiteSpace($selected))
  {
    $parent = Split-Path -parent -path $selected
    cd $parent
    explorer .
  }
  else { cd C:\ }
}
function fzn # Runs fzf searching files then opens the directory of the selected file in neovim - Usage: fzn [d | u | c]
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
  if (![string]::IsNullOrWhiteSpace($selected))
  {
    $parent = Split-Path -parent -path $selected
    cd $parent
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    nvim .
  }
  else { cd C:\ }
}
function fzv # Runs fzf searching files then opens the directory of the selected file in visual studio - Usage: fzv [d | u | c]
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
  if (![string]::IsNullOrWhiteSpace($selected))
  {
    $parent = Split-Path -parent -path $selected
    cd $parent
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    $solution = Get-ChildItem -Path (Get-Location) -Filter *.sln -File | Select-Object -First 1
    if ($solution)
    {
      $solutionName = $solution.Name
      devenv "$solutionName"
    }
    else { devenv . }
  }
  else { cd C:\ }
}
function dzc # Runs fzf searching directories then cd's to the selected directory - Usage: dzc [d | u | c]
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
  if (![string]::IsNullOrWhiteSpace($selected)) { cd $selected }
  else { cd C:\ }
}
function dze # Runs fzf searching directories then opens the selected directory in explorer - Usage: dze [d | u | c]
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
  if (![string]::IsNullOrWhiteSpace($selected))
  {
    cd $selected
    explorer .
  }
  else { cd C:\ }
}
function dzn # Runs fzf searching directories then opens the selected directory in neovim - Usage: dzn [d | u | c]
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
  if (![string]::IsNullOrWhiteSpace($selected))
  {
    cd $selected
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    nvim .
  }
  else { cd C:\ }
}
function dzv # Runs fzf searching directories then opens the selected directory in visual studio - Usage: dzv [d | u | c]
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
  if (![string]::IsNullOrWhiteSpace($selected))
  {
    cd $selected
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"

    $solution = Get-ChildItem -Path (Get-Location) -Filter *.sln -File | Select-Object -First 1
    if ($solution)
    {
      $solutionName = $solution.Name
      devenv "$solutionName"
    }
    else { devenv . }
  }
  else { cd C:\ }
}
function prompt # Custom prompt to remove the "PS" prefix and also keep the tab title up to date
{
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  "$pwd> "
}
