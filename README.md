# Windows11Workflow

All my Neovim config files, using PowerShell in the Windows Terminal along with fzf and bat for fast navigation. Also a quick setup for Tridactyl on Firefox.

This setup enables you to have many buffers open in Neovim that you can easily switch between using Harpoon and Telescope, while also quickly opening entirely different directories in new tabs using fzf which you can easily switch between and close, all while having access to vim motions in your browser.

https://github.com/ConnorSweeneyDev/Windows11Workflow/assets/75945279/a4e1d524-d7db-4bb0-a1d0-54b4ecd1262e

*Showcase: **cw** (cd directory), **ew** (explorer directory), **nw** (nvim . directory), **ctrl+f** in Neovim (new tab + cw), **ctrl+tab** (switch tabs), **:q** (exit terminal), **f** (open firefox with tridactyl).*

# Setup Instructions
### Full Paths to Repository Folders:
- PowerShell &rightarrow; `C:\Users\conno\Documents\PowerShell`
- nvim &rightarrow; `C:\Users\conno\AppData\Local\nvim`
- scripts &rightarrow; `C:\scripts`

### Miscellaneous Prerequisites:
- Ensure "Developer Mode" is turned on in windows settings (Windows + I and then search "developer")

### Terminal Installation:
- Windows Terminal &rightarrow; Run `winget install --id Microsoft.WindowsTerminal`
- PowerShell (pwsh.exe) &rightarrow; Run `winget install --id Microsoft.Powershell --source winget`
- NerdFont &rightarrow; Download from [here](https://www.nerdfonts.com/font-downloads) and put the contents in `C:\Documents\Fonts`, select all and right click then select "Install"\
  You can delete the .ttf files from the folder after you've installed them
### Terminal Settings:
- Startup &rightarrow; "Default profile" = PowerShell. "Default termial application" = Windows Terminal. "Launch size" = 120x25. "Launch parameters" = Center on launch enabled
- Interaction &rightarrow; "Warn when closing more than one tab" = Off
- Appearance &rightarrow; "Use acrylic material in the tab row" = On. "Use active terminal title as application title" = Off
- Actions &rightarrow; Add a new action "Close tab" assigned to `ctrl+shift+d`. Set "Toggle fullscreen" to `alt+enter`
- Defaults &rightarrow; Appearance &rightarrow; "Font face" = CaskaydiaCove Nerd Font. "Font size" = 16. "Background opacity" = 75%
### PowerShell Settings:
- Starting directory &rightarrow; `C:\`
- Appearance &rightarrow; "Font face" = CaskaydiaCove Nerd Font. "Font size" = 16. "Background opacity" = 75%

### Dependencies (Evironment Variables):
- scripts &rightarrow; Put `C:\scripts\which` and `C:\scripts\firefox` in the path
- Microsoft Visual C++ 2015-2022 Redistributable (x64) &rightarrow; Download from [here](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170) and run the installation wizard
- Git &rightarrow; Run `winget install --id Git.Git --source winget` then `git config --system core.longpaths true`
- MinGW &rightarrow; Download from [here](https://winlibs.com/) and put the contents in `C:\MinGW` (Treesitter will only work with 64-bit MinGW)
- Python &rightarrow; Run `winget install --id Python.Python.3.11`
- NodeJS &rightarrow; Run `winget install OpenJS.NodeJS` and say yes to installing Chocolatey
- ripgrep &rightarrow; Run `winget install BurntSushi.ripgrep.MSVC`
- fzf &rightarrow; Run `winget install --id=junegunn.fzf` or download the exe from [here](https://github.com/junegunn/fzf-bin/releases) and put it in `C:\Windows`
- bat &rightarrow; Run `winget install sharkdp.bat`
- NirCmd &rightarrow; Run `winget install --id NirSoft.NirCmd`
- Neovim &rightarrow; Run `winget install neovim`
- Python Provider &rightarrow; Run `pip install pynvim --upgrade`
- NodeJS Provider &rightarrow; Run `npm install -g neovim`
- Packer &rightarrow; Run `git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.knvim"`

### Neovim:
This repository does not cover the installation instructions for after all dependencies are installed, the layout of the nvim folder is simple.\
This is where you should install the plugins. After all plugins are installed and you are not getting any errors, move on to the next section.

### Coc Extensions:
- To get language servers, run `:CocInstall coc-discord-rpc coc-copilot coc-git coc-powershell coc-sh coc-html coc-tsserver coc-css coc-cssmodules coc-json coc-xml coc-sql coc-pyright coc-java coc-omnisharp coc-cmake coc-clangd`

# Firefox With Tridactyl
Go [here](https://www.mozilla.org/en-GB/firefox/new/) to download Firefox and then [here](https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/?utm_source=github.com&utm_content=readme.md) to install the Tridactyl add-on. Also make it the default browser.
After that is up and running go to Firefox settings and change the following:
- General &rightarrow; Use recommended performance settings &rightarrow; Off
- General &rightarrow; Use hardware acceleration when available &rightarrow; Off
- Home &rightarrow; Homepage and new windows &rightarrow; Custom URLs... &rightarrow; Paste `moz-extension://13a1d2f1-5f72-41ad-bbed-17d8bb8bae85/static/newtab.html` &rightarrow; Use Current Page
- Home &rightarrow; Default search engine &rightarrow; Google
- Now go to this url `about:config` and search for `full-screen-api.transition-duration.enter` and `full-screen-api.transition-duration.leave` and change both to `0 0`
- Scan the rest of the settings and disable things you don't want that will slow down the browser

Using Tridactyl, press `:` and type the following commands:
- `set newtab google.com`
- `set searchengine google`
- `set modeindicatorshowkeys true`
- `set modeindicatormodes {"normal":"true","insert":"true","input":"true","ignore":"false","ex":"true","hint":"true","visual":"true"}`

You can go [here](https://github.com/tridactyl/tridactyl?tab=readme-ov-file#highlighted-features) to view all the most important bindings.

# Other Useful Tools
- PowerToys &rightarrow; Run `winget install Microsoft.PowerToys --source winget` - my favourite tools are:\
  Run with an activation shortcut of shift+backspace, input smoothing disabled, clear previous query on launch enabled, preferred monitor primary, all plugins off except window walker - this allows switching windows by searching their name instead of alt tabbing\
  Color Picker with an activation shortcut of win+shift+c\
  Screen Ruler with an activation shortcut of win+shift+p\
  Text Extractor with an activation shortcut of win+shift+t\
  Command Not Found enabled
- SysInternals &rightarrow; Download from [here](https://learn.microsoft.com/en-us/sysinternals/downloads/) and choose the executables that you want - the only one I use is ZoomIt with the following settings:\
  Zoom on ctrl+/ with animate zoom in and zoom out disabled\
  Draw on ctrl+'\
  Record on ctrl+;
- Visual Studio 2022 - Download from [here](https://visualstudio.microsoft.com/vs/) and make sure to put `C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin` in the path if it isn't already
- Make &rightarrow; Run `winget install make --source winget`
- Dependency Walker &rightarrow; Download from [here](https://github.com/lucasg/Dependencies) and put the contents in `C:\DependencyWalker`
- scc &rightarrow; As an admin, run `choco install scc` - details can be found [here](https://github.com/boyter/scc)
