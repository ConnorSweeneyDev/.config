# Windows11Workflow

All my NeoVim config files, using PowerShell in the Windows Terminal along with fzf and bat for fast navigation.

### Dependencies (Ensure these are in the path):
- Windows Terminal &rightarrow; Run `winget install --id Microsoft.WindowsTerminal`
- PowerShell (pwsh.exe) &rightarrow; Run `winget install --id Microsoft.Powershell --source winget`
- MinGW &rightarrow; Download from [here](https://www.mingw-w64.org/downloads/) and put the contents in C:\MinGW
- Python &rightarrow; Run `winget install --id Python.Python.3.11`
- NodeJS &rightarrow; Run `winget install OpenJS.NodeJS`
- ripgrep &rightarrow; Run `winget install BurntSushi.ripgrep.MSVC`
- fzf &rightarrow; Run `winget install --id=junegunn.fzf` OR download the exe from their [GitHub](https://github.com/junegunn/fzf-bin/releases) and put it in C:\Windows
- bat &rightarrow; Run `winget install sharkdp.bat`
- NeoVim &rightarrow; Run `winget install neovim`
- Packer &rightarrow; Run `git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"`

### Full paths to folders in the repo are as follows:
- nvim &rightarrow; C:\Users\conno\AppData\Local\nvim
- which &rightarrow; C:\which
- PowerShell &rightarrow; C:\Users\conno\Documents\PowerShell

### Other tools that are good for development:
- Dependencies &rightarrow; Download from [here](https://github.com/lucasg/Dependencies) and put the contents in C:\Dependency Walker
