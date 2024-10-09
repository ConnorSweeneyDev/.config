Set-Alias -Name "g" -Value "git"

function q { exit }
function c { clear }
function e { explorer . }
function b { explorer shell:RecycleBinFolder }
function n { nvim . }

function wn { wezterm cli spawn --new-window } # Opens a new window
function tn { wezterm cli spawn } # Opens a new tab
function wc { wezterm cli spawn --new-window --cwd $pwd } # Runs wn then changes to the current directory
function tc { wezterm cli spawn --cwd $pwd } # Runs tn then changes to the current directory
function fc { wezterm cli spawn pwsh -NoExit -Command "cw" } # Runs tn then cw
function fe { wezterm cli spawn pwsh -NoExit -Command "ew" } # Runs tn then ew
function fn { wezterm cli spawn pwsh -NoExit -Command "nw" } # Runs tn then nw

function d # Better rm - Usage: d <path1> <path2> ... <pathN>
{
  $paths = $args
  foreach ($path in $paths)
  {
    if (Test-Path $path) { Remove-Item $path -Recurse -Force }
    else { echo "Path does not exist: $path" }
  }
}
function fh # Finds occurences of a string in your command history - Usage: fh <string>
{
  $find = $args
  Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -like "*$find*"} | Sort-Object -Unique -Descending
}

function cw # Changes to the directory of your selected file in fzf, searches C:\Users
{
  cd C:\Users
  $location = which
  if (![string]::IsNullOrWhiteSpace($location)) { cd $location }
  else { cd C:\ }
}
function cwa # Same as cw but searches the entire C:\ drive, not just C:\Users
{
  cd C:\
  $location = which
  if (![string]::IsNullOrWhiteSpace($location)) { cd $location }
}
function ew # Opens the directory in file explorer of your selected file in fzf, searches C:\Users
{
  cd C:\Users
  $location = which
  if (![string]::IsNullOrWhiteSpace($location))
  {
    cd $location
    explorer .
  }
  else { cd C:\ }
}
function ewa # Same as ew but searches the entire C:\ drive, not just C:\Users
{
  cd C:\
  $location = which
  if (![string]::IsNullOrWhiteSpace($location))
  {
    cd $location
    explorer .
  }
}
function nw # Opens the directory in neovim of your selected file in fzf, searches C:\Users
{
  cd C:\Users
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
function nwa # Same as nw but searches the entire C:\ drive, not just C:\Users
{
  cd C:\
  $location = which
  if (![string]::IsNullOrWhiteSpace($location))
  {
    cd $location
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    nvim .
  }
}

function attend
{
  cd C:\Users\conno\Documents\Programming\Python\AttendanceLogger
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  python program/main.py
}
function music
{
  cd C:\Users\conno\Documents\Programming\CPP\TerminalMusicPlayer
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"

  if ($args.Count -eq 0) { .\binary\TerminalMusicPlayer.exe }
  elseif ($args -eq "-s")
  {
    $directoryPath = Get-Content -Path user\songs_directory.txt -First 1
    $selectedSong = Get-ChildItem -Path $directoryPath -File | ForEach-Object { $_.Name } | fzf -m
    if (![string]::IsNullOrWhiteSpace($selectedSong)) { .\binary\TerminalMusicPlayer.exe $selectedSong }
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

# Komorebi
$Env:KOMOREBI_CONFIG_HOME = $Env:USERPROFILE + "/.config/komorebi"

# OhMyPosh
oh-my-posh init pwsh --config $Env:USERPROFILE/.config/posh/config.omp.json | Invoke-Expression
# Which
$Env:WHICH = $Env:USERPROFILE + "/.config/which"
# FZF
$Env:FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix --hidden --exclude .git'

# Neovim
$Env:XDG_CONFIG_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_DATA_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_STATE_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_CACHE_HOME = $Env:USERPROFILE + "/.config/temp"
$Env:NVIM_LOG_FILE = $Env:USERPROFILE + "/.config/nvim-data"
