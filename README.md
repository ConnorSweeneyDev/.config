# Windows11Workflow

All my Neovim config files, using PowerShell in the Windows Terminal along with fzf and bat for fast navigation.\
This setup enables you to have many buffers open in Neovim that you can easily switch between using Harpoon and Telescope, while also quickly opening entirely different directories in new tabs using fzf which you can easily switch between and close.

https://github.com/ConnorSweeneyDev/Windows11Workflow/assets/75945279/618eca1f-b5ce-4874-9753-19d537bba6c3

*Showcase: **cw** (cd), **ew** (explorer.exe), **nw** (nvim .), **ctrl+f** in Neovim (new tab + nw), **q** (exit).*\
**Disclaimer: This was recursively searching my whole C drive, which is why it is slightly slow, this is customisable.**

## Miscellaneous Prerequisites
- Ensure "Developer Mode" is turned on in windows settings (Windows + I and then search "developer")

## Terminal
- Windows Terminal &rightarrow; Run `winget install --id Microsoft.WindowsTerminal`
- PowerShell (pwsh.exe) &rightarrow; Run `winget install --id Microsoft.Powershell --source winget`
- NerdFont &rightarrow; Download from [here](https://www.nerdfonts.com/font-downloads) and put the contents in C:\Documents\Fonts, select all and right click then select install
### Terminal Settings:
- Startup &rightarrow; "Default profile" = PowerShell. "Default termial application" = Windows Terminal
- Interaction &rightarrow; "Warn when closing more than one tab" = Off
- Appearance &rightarrow; "Use acrylic material in the tab row" = On. "Use active terminal title as application title" = Off
- Actions &rightarrow; Add a new action "Close tab" assigned to `ctrl+shift+d`. Set "Toggle fullscreen" to `alt+enter`
- Defaults &rightarrow; Appearance &rightarrow; "Font face" = CaskaydiaCove Nerd Font. "Font size" = 16. "Background opacity" = 75%
### PowerShell Settings:
- Starting directory &rightarrow; C:\
- Appearance &rightarrow; "Font face" = CaskaydiaCove Nerd Font. "Font size" = 16. "Background opacity" = 75%

## Dependencies (Evironment Variables)
- Microsoft Visual C++ 2015-2022 Redistributable (x64) &rightarrow; Download from [here](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170) and run the installation wizard
- Git &rightarrow; Run `winget install --id Git.Git --source winget`, then `git config --system core.longpaths true`
- MinGW &rightarrow; Download from [here](https://www.mingw-w64.org/downloads/) and put the contents in C:\MinGW
- Python &rightarrow; Run `winget install --id Python.Python.3.11`
- NodeJS &rightarrow; Run `winget install OpenJS.NodeJS` and say yes to installing Chocolatey
- ripgrep &rightarrow; Run `winget install BurntSushi.ripgrep.MSVC`
- fzf &rightarrow; Run `winget install --id=junegunn.fzf` OR download the exe from their [GitHub](https://github.com/junegunn/fzf-bin/releases) and put it in C:\Windows
- bat &rightarrow; Run `winget install sharkdp.bat`
- Neovim &rightarrow; Run `winget install neovim`
- Python Provider &rightarrow; Run `pip install pynvim --upgrade`
- Packer &rightarrow; Run `git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"`

## Coc Extensions
- After installing Coc.nvim, run `CocInstall coc-discord-rpc coc-copilot coc-git coc-powershell coc-sh coc-html coc-tsserver coc-css coc-cssmodules coc-json coc-xml coc-sql coc-pyright coc-java coc-omnisharp coc-cmake coc-clangd`

## Full Paths to Repository Folders
- nvim &rightarrow; C:\Users\conno\AppData\Local\nvim
- which &rightarrow; C:\which
- PowerShell &rightarrow; C:\Users\conno\Documents\PowerShell

## Other Useful Development Tools
- Make &rightarrow; Run `winget install make --source winget`
- Dependency Walker &rightarrow; Download from [here](https://github.com/lucasg/Dependencies) and put the contents in C:\Dependency Walker
- scc &rightarrow; As an admin, run `choco install scc` - details can be found [here](https://github.com/boyter/scc)
