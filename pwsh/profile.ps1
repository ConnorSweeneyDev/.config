$Env:KOMOREBI_CONFIG_HOME = $Env:USERPROFILE + "/.config/komorebi"
$Env:FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix --hidden --exclude .git'
$Env:WHICH = $Env:USERPROFILE + "/.config/which"
$Env:NVIM_LOG_FILE = $Env:USERPROFILE + "/.config/nvim-data"
$Env:XDG_CONFIG_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_DATA_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_STATE_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_CACHE_HOME = $Env:USERPROFILE + "/.config/temp"

Set-Alias -Name "g" -Value "git"
Set-Alias -Name "c" -Value "clear"

function q { exit }
function e { explorer . }
function b { explorer shell:RecycleBinFolder }
function n { nvim . }

function w { wezterm cli spawn --new-window --cwd $pwd } # Opens a new window at the current directory
function t { wezterm cli spawn --cwd $pwd } # Opens a new tab at the current directory

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
  $selected = Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -like "*$find*"} | Sort-Object -Unique -Descending | fzf
  if (![string]::IsNullOrWhiteSpace($selected)) { Set-Clipboard $selected }
}

function cw # Changes to the directory of your selected file in fzf searching either D:\, C:\ or C:\Users
{
  if ($args.Count -eq 0 -or $args -eq "d") { cd D:\ }
  elseif ($args -eq "c") { cd C:\ }
  elseif ($args -eq "u") { cd C:\Users }
  else
  {
    echo "Invalid argument: $args"
    return
  }
  $location = which
  if (![string]::IsNullOrWhiteSpace($location)) { cd $location }
  else { cd C:\ }
}
function ew # Opens the directory in file explorer of your selected file in fzf searching either D:\, C:\ or C:\Users
{
  if ($args.Count -eq 0 -or $args -eq "d") { cd D:\ }
  elseif ($args -eq "c") { cd C:\ }
  elseif ($args -eq "u") { cd C:\Users }
  else
  {
    echo "Invalid argument: $args"
    return
  }
  $location = which
  if (![string]::IsNullOrWhiteSpace($location))
  {
    cd $location
    explorer .
  }
  else { cd C:\ }
}
function nw # Opens the directory in neovim of your selected file in fzf searching either D:\, C:\ or C:\Users
{
  if ($args.Count -eq 0 -or $args -eq "d") { cd D:\ }
  elseif ($args -eq "c") { cd C:\ }
  elseif ($args -eq "u") { cd C:\Users }
  else
  {
    echo "Invalid argument: $args"
    return
  }
  $location = which
  if (![string]::IsNullOrWhiteSpace($location))
  {
    cd $location
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    nvim .
  }
  else { cd C:\ }
}
function fd { wezterm cli spawn pwsh -NoExit -Command "nw d" } # Opens a new tab then runs "nw d"
function fu { wezterm cli spawn pwsh -NoExit -Command "nw u" } # Opens a new tab then runs "nw u"

function attend
{
  cd D:\Python\AttendanceLogger
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  python program/main.py
}
function music
{
  cd D:\CPP\TerminalMusicPlayer
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"

  if ($args.Count -eq 0) { .\binary\TerminalMusicPlayer.exe }
  elseif ($args -eq "-s")
  {
    $directoryPath = Get-Content -Path user\songs_directory.txt -First 1
    $selectedSongs = Get-ChildItem -Path $directoryPath -File | ForEach-Object { $_.Name } | fzf -m
    if (![string]::IsNullOrWhiteSpace($selectedSongs)) { .\binary\TerminalMusicPlayer.exe $selectedSongs }
  }
  elseif ($args -eq "-c") { .\binary\TerminalMusicPlayer.exe -c }
  elseif ($args -eq "-r") { .\binary\TerminalMusicPlayer.exe -r }
  else { echo "Invalid argument: $args" }
}

function prompt # Custom prompt to remove the "PS" prefix and also keep the tab title up to date
{
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  "$pwd> "
}

Set-PSReadLineOption -PredictionViewStyle ListView
oh-my-posh init pwsh --config $Env:USERPROFILE/.config/posh/config.omp.json | Invoke-Expression
