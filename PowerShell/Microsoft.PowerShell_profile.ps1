function q { exit }
function :q { exit }
function c { clear }
function e { explorer . }
function n { nvim . }
function f
{
    firefoxfocusfix
    exit
}

function cw
{
    cd C:\
    cd (C:\scripts\which\which.bat)
}
function ew
{
    cd C:\
    cd (C:\scripts\which\which.bat)
    explorer $PWD
}
function nw
{
    cd C:\
    cd (C:\scripts\which\which.bat)
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

function prompt
{
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    "$pwd> "
}
