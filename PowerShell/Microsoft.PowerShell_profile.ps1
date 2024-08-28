function :q { exit }
function q { exit }
function w { wt }
function t { wt --window 0 }
function c { clear }
function e { explorer . }
function b { explorer shell:RecycleBinFolder }
function n { nvim . }
function f { firefoxfocusfix }

function cw
{
  cd C:\Users
  $location = which
  if (![string]::IsNullOrWhiteSpace($location)) { cd $location }
}
function ew
{
  cd C:\Users
  $location = which
  if (![string]::IsNullOrWhiteSpace($location))
  {
    cd $location
    explorer .
  }
}
function nw
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
}
function cwa
{
  cd C:\
  $location = which
  if (![string]::IsNullOrWhiteSpace($location)) { cd $location }
}
function ewa
{
  cd C:\
  $location = which
  if (![string]::IsNullOrWhiteSpace($location))
  {
    cd $location
    explorer .
  }
}
function nwa
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

function fh
{
  $find = $args
  Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -like "*$find*"} | Sort-Object -Unique -Descending
}
function nh
{
  $directory = Split-Path (Get-PSReadlineOption).HistorySavePath
  cd $directory
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  nvim .
}

function ep
{
  $directory = Split-Path $PROFILE
  cd $directory
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  explorer .
}
function np
{
  $directory = Split-Path $PROFILE
  cd $directory
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  nvim .
}

function attend
{
  cd C:\Users\conno\Documents\Programming\Web\AutoAttendance
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  .\script\run.bat -nowin
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

function prompt
{
  $p = Split-Path -leaf -path (Get-Location)
  $Host.UI.RawUI.WindowTitle = "$p"
  "$pwd> "
}

oh-my-posh init pwsh --config "C:/posh/config.omp.json" | Invoke-Expression
$Env:KOMOREBI_CONFIG_HOME = 'C:/Users/conno/Komorebi'
