$Env:KOMOREBI_CONFIG_HOME = $Env:USERPROFILE + "/.config/komorebi"
$Env:XDG_CONFIG_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_DATA_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_STATE_HOME = $Env:USERPROFILE + "/.config"
$Env:XDG_CACHE_HOME = $Env:USERPROFILE + "/.config/temp"
$Env:NVIM_LOG_FILE = $Env:USERPROFILE + "/.config/nvim-data"
$Env:FZF_FILE_COMMAND = "fd --type f --strip-cwd-prefix --hidden --exclude .git --no-ignore"
$Env:FZF_FILE_OPTS = "--preview=`"bat --style=numbers --color=always {}`" --preview-window=border-rounded --preview-label=`" PREVIEW `" --border=rounded --border-label=`" FILES `" --tabstop=2 --color=16 --bind=ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"
$Env:FZF_DIRECTORY_COMMAND = "fd --type d --strip-cwd-prefix --hidden --exclude .git --no-ignore"
$Env:FZF_DIRECTORY_OPTS = "--preview=`"pwsh -NoProfile -Command Get-ChildItem -Force -LiteralPath '{}'`" --preview-window=border-rounded --preview-label=`" PREVIEW `" --border=rounded --border-label=`" DIRECTORIES `" --tabstop=2 --color=16 --bind=ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"
$Env:BAT_THEME = "Visual Studio Dark+"
