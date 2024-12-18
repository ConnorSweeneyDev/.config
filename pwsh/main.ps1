. $Env:USERPROFILE"\.config\pwsh\environment.ps1"
. $Env:USERPROFILE"\.config\pwsh\alias.ps1"
. $Env:USERPROFILE"\.config\pwsh\utility.ps1"
. $Env:USERPROFILE"\.config\pwsh\personal.ps1"
oh-my-posh init pwsh --config $Env:USERPROFILE/.config/posh/config.omp.json | Invoke-Expression
