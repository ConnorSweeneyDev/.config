# Windows11Workflow

All my NeoVim config files, using PowerShell in the Windows Terminal along with fzf and bat for fast navigation.

## Terminal (Required):
- Windows Terminal &rightarrow; Run `winget install --id Microsoft.WindowsTerminal`
- PowerShell (pwsh.exe) &rightarrow; Run `winget install --id Microsoft.Powershell --source winget`
- NerdFont &rightarrow; Download from [here](https://www.nerdfonts.com/font-downloads) and put the contents in C:\Documents\Fonts, select all and click install
### Terminal Settings:
- Startup &rightarrow; "Default profile" = PowerShell. "Default termial application" = Windows Terminal. Everything else default.
- Appearance &rightarrow; "Use acrylic material in the tab row" = On. "Use active terminal title as application title" = Off. Everything else default.
- Actions &rightarrow; Add a new action "Close tab" assigned to `ctrl+shift+d`. Set "Toggle fullscreen" to `alt+enter`.
- Defaults &rightarrow; Appearance &rightarrow; "Font face" = CaskaydiaCove. "Font size" = 16. "Background opacity" = 75%.
### PowerShell Settings:
- Starting directory &rightarrow; C:\
- Appearance &rightarrow; "Font face" = CaskaydiaCove. "Font size" = 16. "Background opacity" = 75%.

## Dependencies (Ensure these are in the path):
- MinGW &rightarrow; Download from [here](https://www.mingw-w64.org/downloads/) and put the contents in C:\MinGW
- Python &rightarrow; Run `winget install --id Python.Python.3.11`
- NodeJS &rightarrow; Run `winget install OpenJS.NodeJS`
- ripgrep &rightarrow; Run `winget install BurntSushi.ripgrep.MSVC`
- fzf &rightarrow; Run `winget install --id=junegunn.fzf` OR download the exe from their [GitHub](https://github.com/junegunn/fzf-bin/releases) and put it in C:\Windows
- bat &rightarrow; Run `winget install sharkdp.bat`
- NeoVim &rightarrow; Run `winget install neovim`
- Packer &rightarrow; Run `git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"`

## Full paths to folders in the repo are as follows:
- nvim &rightarrow; C:\Users\conno\AppData\Local\nvim
- which &rightarrow; C:\which
- PowerShell &rightarrow; C:\Users\conno\Documents\PowerShell

## Other tools that are good for development:
- Dependencies &rightarrow; Download from [here](https://github.com/lucasg/Dependencies) and put the contents in C:\Dependency Walker
