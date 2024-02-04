# WorkflowForWindows11

All my Neovim config files (using packer), along with fzf for PowerShell commands and shortcuts.

### Dependencies:
- Windows Terminal -> winget install -e --id Microsoft.WindowsTerminal
- PowerShell (pwsh.exe) -> winget install --id Microsoft.Powershell --source winget
- MinGW -> C:\MinGW (https://www.mingw-w64.org/downloads/)
- Python -> winget install -e --id Python.Python.3.11
- NodeJS -> winget install OpenJS.NodeJS
- ripgrep -> winget install BurntSushi.ripgrep.MSVC
- fzf -> winget install --id=junegunn.fzf OR download the exe from here and put it in C:\Windows https://github.com/junegunn/fzf-bin/releases
- bat -> winget install sharkdp.bat
- Neovim -> winget install neovim
- Packer -> git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

### Full paths to folders in the repo are as follows:
- nvim -> C:\Users\conno\AppData\Local\nvim
- which -> C:\which
- PowerShell -> C:\Users\conno\Documents\PowerShell

### Other tools that are good for development:
- Dependencies -> C:\Dependency Walker (https://github.com/lucasg/Dependencies)
