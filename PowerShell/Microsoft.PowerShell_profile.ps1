function q {
    exit
}

function cw {
    cd C:\
    cd (C:\which\which.bat)
}

function ew {
    cd C:\
    explorer.exe (C:\which\which.bat)
}

function nw {
    cd C:\
    cd (C:\which\which.bat)
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    nvim .
}

function attend {
    cd C:\Users\conno\Documents\Programming\Web\AutoLogAttendance
    C:\Users\conno\Documents\Programming\Web\AutoLogAttendance\run.bat -nowin
}

function prompt {
    $p = Split-Path -leaf -path (Get-Location)
    $Host.UI.RawUI.WindowTitle = "$p"
    "$pwd> "
}
