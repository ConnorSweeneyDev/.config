function :q { exit }
function q { exit }
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

function prompt
{
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    "$pwd> "
}

#34de4b3d-13a8-4540-b76d-b9e8d3851756 PowerToys CommandNotFound module

Import-Module "C:\Program Files\PowerToys\WinUI3Apps\..\WinGetCommandNotFound.psd1"
#34de4b3d-13a8-4540-b76d-b9e8d3851756
