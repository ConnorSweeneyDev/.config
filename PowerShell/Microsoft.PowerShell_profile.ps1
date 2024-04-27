function :q { exit }
function q { exit }
function t { wt --window 0 }
function c { clear }
function e { explorer . }
function b { explorer shell:RecycleBinFolder }
function n { nvim . }
function f { firefoxfocusfix }

function cw
{
    cd C:\
    cd (which)
}
function ew
{
    cd C:\
    cd (which)
    explorer $PWD
}
function nw
{
    cd C:\
    cd (which)
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    nvim .
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
    nvim ConsoleHost_history.txt
}
function np
{
    $directory = Split-Path $PROFILE
    cd $directory
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    nvim Microsoft.PowerShell_profile.ps1
}

function attend
{
    cd C:\Users\conno\Documents\Programming\Web\AutoLogAttendance
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    .\run.bat -nowin
}

function music
{
    cd C:\Users\conno\Documents\Programming\C++\TerminalMusicPlayer
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    .\bin\TerminalMusicPlayer.exe
}

function prompt
{
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    "$pwd> "
}
