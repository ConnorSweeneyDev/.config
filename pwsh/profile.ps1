$Env:KOMOREBI_CONFIG_HOME = $Env:USERPROFILE + "/.config/komorebi"
$Env:XDG_CONFIG_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_DATA_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_STATE_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_CACHE_HOME = $Env:USERPROFILE + "/.config/temp"
$Env:NVIM_LOG_FILE = $Env:USERPROFILE + "/.config/nvim-data"
$Env:BAT_THEME = "Visual Studio Dark+"

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

function tvc
{
  $selected = tv $args
  if (![string]::IsNullOrWhiteSpace($selected)) { cd $selected }
}
function tve
{
  $selected = tv $args
  if (![string]::IsNullOrWhiteSpace($selected))
  {
    cd $selected
    explorer .
  }
}
function tvn
{
  $selected = tv $args
  if (![string]::IsNullOrWhiteSpace($selected))
  {
    cd $selected
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    nvim .
  }
}

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

oh-my-posh init pwsh --config $Env:USERPROFILE/.config/posh/config.omp.json | Invoke-Expression
