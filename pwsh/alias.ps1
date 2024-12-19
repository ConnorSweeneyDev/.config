Set-Alias -Name "c" -Value "clear"
Set-Alias -Name "g" -Value "git"
function q { exit }
function e { explorer . }
function b { explorer shell:RecycleBinFolder }
function n { nvim . }
function w { wezterm cli spawn --new-window --cwd $pwd } # Opens a new window at the current directory
function t { wezterm cli spawn --cwd $pwd } # Opens a new tab at the current directory
