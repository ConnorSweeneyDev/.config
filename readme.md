# Welcome
Thse are all my Windows dotfiles and how to set them up, using Wezterm with Neovim in PowerShellCore along with fzf.
Additionally there's a setup for a Tiling Window Manager using Komorebi, Yasb and AutoHotkey, and a Tridactyl setup for
Firefox. You will also find a list of other useful tools at the end.

https://github.com/user-attachments/assets/298d47ea-595c-42d5-b092-fea8f2adaabf

# System
> [!NOTE]
> Every folder in this repository is located locally at `$Env:USERPROFILE\.config`.

### Setup
- Ensure "Developer Mode" is turned on in windows settings (Windows + I and then search `developer`).
- Ensure you are able to access and use the Windows Store, winget relies on this for certain things. If you can't access
  the store (it's known to be glitchy for some accounts) then you can find alternative installs for all dependencies on
  either [Chocolatey](https://chocolatey.org/install#individual) or the dependency's official website.
- You can right click your desktop and go to "View" and then "Hide desktop icons" to have a clean desktop.

# Terminal
### Dependencies
- NerdFont &rightarrow; Download from [here](https://www.nerdfonts.com/font-downloads) (I use CaskaydiaCove), then in
  explorer select all `.ttf` files and right click them, now select "Install". After that you can delete the files.
- WezTerm &rightarrow; Run `winget install --id wez.wezterm`.
- PowerShellCore &rightarrow; Run `winget install --id Microsoft.Powershell --source winget`.
- gsudo &rightarrow; Run `winget install --id gerardog.gsudo`.
- Git &rightarrow; Run `winget install --id Git.Git --source winget`.
- Difftastic &rightarrow; Run `winget install difftastic`.
- OhMyPosh &rightarrow; Run `winget install JanDeDobbeleer.OhMyPosh`.
- fd &rightarrow; Run `winget install --id sharkdp.fd --source winget`.
- bat &rightarrow; Run `winget install sharkdp.bat`.
- fzf &rightarrow; Run `winget install junegunn.fzf`.

### Setup
- Paste `wezterm` into your config and change the font face to whatever NerdFont you installed. You can go to
  `C:\ProgramData\Microsoft\Windows\Start Menu\Programs` and rename the WezTerm shortcut to something shorter like `wt`
  for ease of typing in the start menu.
- Paste `posh` into your config and run `oh-my-posh disable notice` to stop the annoying update message every so often.
- Paste `pwsh` into your config, then run `notepad $PROFILE` and paste this line into the file that is opened (you may
  have to create the file first if it doesn't exist): `. $Env:USERPROFILE"\.config\pwsh\main.ps1"`.
- Go back to `pwsh\main.ps1` and remove the line that sources `personal.ps1`, and delete that file too as it is specific
  to me. Other than that, skim the rest of the files and remove anything you know you won't need - everything is
  commented or self-explanatory so you can be sure of what you're doing.
- To set up gsudo after installing it, run the following commands:
  - `sudo config PowerShellLoadProfile true`.
  - `sudo config CacheMode auto`.
  - `sudo config CacheDuration infinite`.
  - `sudo config LogLevel None`.
- Run `git config --system core.longpaths true` and ensure that `[PATH_TO_GIT]\bin` is in your path. After that you can
  use the following configuration in your `$Env:USERPROFILE\.gitconfig` file if you want:
  ```
  [alias]
    i = init
    re = remote
    rs = restore
    cl = clone
    pl = pull
    a = add
    co = commit
    ps = push
    sm = submodule
    b = branch
    ch = checkout
    m = merge
    s = status
    d = diff
    l = log --graph --decorate --pretty=oneline --abbrev-commit --all
  [diff]
    external = difft
  ```

# Neovim
> [!IMPORTANT]
> This section requires completion of the terminal setup first.

### Dependencies
- Microsoft Visual C++ 2015-2022 Redistributable (x64) &rightarrow; Download from
  [here](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170) and run the
  installation wizard.
- Java &rightarrow; Download the compressed archive from [here](https://www.oracle.com/java/technologies/downloads/) and
  place the folder named `jdk-[VERSION]` in `C:\Program Files\Java` then add `C:\Program Files\Java\jdk-[VERSION]\bin`
  to your path.
- MinGW &rightarrow; Download from [here](https://winlibs.com/) and put the contents in `C:\MinGW` (I recommend 64-bit
  with POSIX threads for general purpose use). Add `C:\MinGW\bin` to your path.
- Make &rightarrow; Run `winget install --id ezwinports.make`.
- CMake &rightarrow; Run `winget install --id Kitware.CMake`.
- Python &rightarrow; Run `winget install --id Python.Python.3.10`.
- NodeJS &rightarrow; Run `winget install OpenJS.NodeJS` and say yes to installing Chocolatey.
- ripgrep &rightarrow; Run `winget install BurntSushi.ripgrep.MSVC`.
- Neovim &rightarrow; Run `winget install neovim --version 0.10.3`.
- Python Provider &rightarrow; Run `pip install pynvim --upgrade`.
- NodeJS Provider &rightarrow; Run `npm install -g neovim`.

### Setup
After completing the dependencies for this section, I recommend manually recreating `nvim` on your machine rather than
just pasting it in, because this will allow you to single out any unexpected errors as they happen.

You should start with the top level `init.lua` and then `lua\main\init.lua`. Then you can create `lua\main\util.lua`,
`lua\main\set.lua` and `lua\main\map.lua` and paste the config into each. `set.lua` is for global neovim settings,
`map.lua` is for neovim keybinds and `util.lua` is for helper functions used throughout the configuration, designed to
remove the need for visible logic in any configuration files.

Now you can create `lua\main\lazy.lua`, and populate it with only the following lines:
```lua
lazy_util.bootstrap()
map("n", "<LEADER>l", "<CMD>Lazy<CR>")
require("lazy").setup{
}
```
After creating an empty `lua\plugin\init.lua`, restart neovim and there should be no error messages.

Now, inside the `.setup` field start adding plugins, do so in the following pattern (with some exceptions below):
- Add the line to `lua\main\lazy.lua` and restart neovim.
- If it needs one, add a `lua\plugin\[PLUGIN].lua` file for the plugin and add `require("plugin.[PLUGIN]")` to
  `lua\plugin\init.lua` (order matters in this file), then restart neovim.
- Customize the file to your liking.
- Test the plugin.

The following plugins require some extra or different steps:
- Helpers &rightarrow; Some plugins are only here to help other plugins and files which you can remove if you don't
  need, these are:
  - plenary.nvim &rightarrow; Required by telescope.nvim, harpoon and neogit.
  - nui.nvim &rightarrow; Required by noice.nvim.
  - nvim-web-devicons &rightarrow; Required by most plugins that use icons.
- Yanky &rightarrow; This plugin requires telescope to be installed, so make sure to do that first.
- Leap &rightarrow; This should be installed at the same time as leap-by-word.nvim, `lua\plugin\leap.lua` requires
  both of these plugins to be installed.
- Colorscheme &rightarrow; vscode.nvim's plugin file is is `lua\plugin\colors.lua`. You don't have to use that
  cholorscheme, but the file assumes you are and lualine is also set up to use the vscode colorscheme so you'll need to
  change those too if you want a different scheme.
- Treesitter &rightarrow; After following the pattern, you should see it compiling languages - don't touch your keyboard
  until this is finished, though it is common to get errors at this point, if you do, generally restarting neovim a few
  times and deleting any directories manually that it says it doesn't have permission to delete will let them all figure
  themselves out. However if you get an error along the lines of `[LANGUAGE].so is not a valid Win32 app`, this means
  either your version of MinGW does not match your operating system or treesitter is using the wrong compiler for that
  specific language. After fixing the issue you can run `:TSInstall [LANGUAGE]` to recompile it.
- Noice &rightarrow; This should be installed at the same time as notify.nvim.
- Coc &rightarrow; `lua\plugin\coc.lua` requires treesitter to run, so install that first. After following the pattern,
  run `:CocInstall coc-diagnostic coc-git coc-html coc-tsserver coc-css coc-json coc-xml coc-pyright coc-java coc-clangd
  coc-rust-analyzer coc-clang-format-style-options` then `:q` to close the dialog once everything is installed. Now add
  `coc-settings.json`, where you should add the path to your java installation instead of my one, then restart again. If
  you don't want one of the listed servers, dont include them or just run `:CocUninstall [SERVER]` after the first
  command. If a language you want is missing, you can find it
  [here](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions).
- Neogit &rightarrow; This should be installed at the same time as diffview.nvim.
- Supermaven &rightarrow; If you don't have a subscription, you can still use it by running `:SupermavenUseFree` when
  prompted, otherwise you can follow the instructions to use it with a subscription.

After all of that, don't forget to include these files that are not tied to any plugins if you want them:
- `lua\plugin\language.lua` is the file this configuration uses to set up language specific settings and mappings.
- `lua\plugin\buffers.lua` is optional as it can slow down the startup time but will open, in separate buffers, every
  file in the specified directory that has any of the file extensions specified - this can be useful for certain
  language servers. If you need to close all the buffers except the current one (when you need to rename symbols, go to
  references etc.), this file also provides the keybind for that, and the keybind for re-opening them all again too. It
  also has a toggle for whether you are using Coc or not, so it is not necessary to use Coc to use this file.

> [!TIP]
> All global keybinds and settings can be edited at `lua\main\map.lua`, `lua\main\set.lua` or the respective
> `lua\plugin\[PLUGIN].lua` files and you can go into deeper detail inside `lua\main\util.lua`. Furthermore, all
> language specific settings and mappings can be edited at `lua\plugin\language.lua` and language server settings
> can be edited at `coc-settings.json`.

> [!NOTE]
> I also have an extremely minimal setup (one file) that can be cloned and run on any machine that can run neovim. You
> can find it [here](https://github.com/ConnorSweeneyDev/nvim-portable), I only use it when I have to use a remote
> machine or someone else's computer.

# Tiling Window Manager
### Dependencies
- Komorebi &rightarrow; Run `winget install LGUG2Z.komorebi --version 0.1.30`.
- Yasb &rightarrow; Run `winget install --id AmN.yasb --version 1.2.7`.
- AutoHotkey &rightarrow; Run `winget install AutoHotkey.AutoHotkey --version 2.0.18`.
- ToggleRoundedCorners &rightarrow; Download the portable executable from
  [here](https://github.com/oberrich/win11-toggle-rounded-corners/releases) and rename it to `trc.exe`. Place it in
  `C:\ToggleRoundedCorners` and put that folder in your path.

### Setup
- Run `Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1` in
  PowerShellCore as an admin.
- Open control panel and go to the "Ease of Access Center" then "Make the computer easier to see" - enable "Turn off all
  unnecessary animations (when possible)".
- Press Windows + I and search `taskbar`, go to taskbar settings and turn on "Automatically hide the taskbar" under the
  taskbar behaviours.
- Search `multitasking` and turn off everything under the snap windows section except "Show my snapped windows when I
  hover over taskbar apps... ...when I press Alt+Tab".
- Paste `komorebi` into your config. In `komorebi.json` ensure that the correct amount of monitors are configured.
- Paste `yasb` into your config. Add `$Env:USERPROFILE\AppData\Local\Yasb` to your path.
- Paste `ahk` into your config. Right click `wm.ahk` and create a shortcut, then rename that shortcut to just `wm` and
  create a copy of it, one should be moved to `C:\ProgramData\Microsoft\Windows\Start Menu\Programs` and the other to
  that folder's sub-directory `Startup`. Now it will be run at startup and is accessible from the start menu in case you
  need to restart the manager, and all three processes can be killed from the task manager.
- Restart your PC.

> [!TIP]
> Keybinds and commands to run on startup can be configured in `wm.ahk`, the status bar can be configured in the Yasb
> `config.yaml` and `styles.css` files, and the window manager can be configured by Komorebi's `komorebi.json`,
> `applications.yaml` and any `.json` files for custom layouts.

# Firefox with Tridactyl
### Dependencies
- Firefox &rightarrow; Download from [here](https://www.mozilla.org/en-GB/firefox/new/).
- Tridactyl &rightarrow; Go
  [here](https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/?utm_source=github.com&utm_content=readme.md) on
  Firefox.

### Setup
First, make firefox your default browser and make the folder containing `firefox.exe` an environment variable
(`C:\Program Files\Mozilla Firefox` by default). After that go to Firefox settings and change the following:
- General &rightarrow; Use recommended performance settings = Off.
- General &rightarrow; Use hardware acceleration when available = Off.
- Home &rightarrow; Homepage and new windows &rightarrow; Custom URLs... &rightarrow; Open a new tab, then close it and
  go to your history, copy the url of that closed tab and paste it into the field - it should be of the form
  `moz-extension://[NUMBERS]/static/newtab.html`.
- Home &rightarrow; Default search engine = Google.
- Now go to the url `about:config` and search for `full-screen-api.transition-duration.enter` and
  `full-screen-api.transition-duration.leave` and change both to `0 0`.
- Scan the rest of the settings and disable things you don't want that will slow down the browser.
- Optionally, you can install the black
  [theme](https://addons.mozilla.org/en-GB/firefox/addon/black21/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
  I use or find your own on their themes [page](https://addons.mozilla.org/firefox/themes).

Using Tridactyl, press `:` and type the following commands:
- `colorscheme midnight`.
- `set newtab about:newtab`.
- `set searchengine google`.
- `set modeindicatorshowkeys true`.
- `set modeindicatormodes
  {"normal":"true","insert":"true","input":"true","ignore":"false","ex":"true","hint":"true","visual":"true"}`.

> [!TIP]
> You can go [here](https://github.com/tridactyl/tridactyl?tab=readme-ov-file#highlighted-features) to view all the most
> important Tridactyl bindings.

# Other Useful Tools
VimForVoyager &rightarrow; Go [here](https://github.com/ConnorSweeneyDev/VimForVoyager) and follow the setup guide for a
native Vim toggle for QMK keyboards.

PowerToys &rightarrow; Run `winget install Microsoft.PowerToys --source winget` and enable Run at
startup - my favourite tools are:
- Run with an activation shortcut of `shift+backspace`, input smoothing disabled, clear previous query on launch
  enabled, preferred monitor primary, all plugins off except "Program" - this behaves just like the windows run dialog
  but without cortana, searching the internet or any other annoyances.
- Color Picker with an activation shortcut of `win+shift+c` and HEX, RGB and VEC4 enabled.
- Mouse Jump with an activation shortcut of `win+shift+d` and a max size of `1200x900`.
- Screen Ruler with an activation shortcut of `win+shift+p`.
- Text Extractor with an activation shortcut of `win+shift+t`.
- File Locksmith enabled.

SysInternals &rightarrow; Download from [here](https://learn.microsoft.com/en-us/sysinternals/downloads/) and choose the
executables that you want - the only one I use is ZoomIt with the following settings:
- Run ZoomIt when Windows starts and Show tray icon both enabled.
- Zoom on `ctrl+/` with animate zoom in and zoom out disabled.
- Draw on `ctrl+'`.
- Record on `ctrl+;`.

WinLister &rightarrow; Go [here](https://www.nirsoft.net/utils/winlister.html) and click "Download WinLister 64-bit",
move the executable to `C:\WinLister`, then right click `winlister.exe` and select "Create shortcut", then rename it to
`WinLister` and place this shortcut in `C:\ProgramData\Microsoft\Windows\Start Menu\Programs`.

Visual Studio 2022 &rightarrow; Download from [here](https://visualstudio.microsoft.com/vs/) and go through the
installation wizard.

Dependencies &rightarrow; Download from [here](https://github.com/lucasg/Dependencies) and put the contents in
`C:\Dependencies`, make that folder is an environment variable, then right click `DependenciesGui.exe` and select
"Create shortcut" and rename it to `Dependencies`, then move that to `C:\ProgramData\Microsoft\Windows\Start
Menu\Programs`.

Everything &rightarrow; Download the portable zip from [here](https://www.voidtools.com/) and put the contents in
`C:\Everything`. Right click `Everything.exe` and select "Create shortcut", then rename it to `Everything` and place
this shortcut in `C:\ProgramData\Microsoft\Windows\Start Menu\Programs`.

Cutter &rightarrow; Download from [here](https://github.com/rizinorg/cutter/releases) and put the contents in
`C:\Cutter`. Right click `cutter.exe` and select "Create shortcut", then rename it to `Cutter` and place this shortcut
in `C:\ProgramData\Microsoft\Windows\Start Menu\Programs`.

Black &rightarrow; Run `pip install git+https://github.com/psf/black`.

Prettier &rightarrow; Run `npm install -g prettier`.

Portal &rightarrow; Run `winget install SpatiumPortae.portal`, go [here](https://github.com/SpatiumPortae/portal) for
instructions.

Mp3tag &rightarrow; Download from [here](https://www.mp3tag.de/en/download.html) and go through the installation wizard.

scc &rightarrow; As an admin, run `choco install scc` - details can be found [here](https://github.com/boyter/scc).

Windows11CursorConceptV2.2 &rightarrow; Go
[here](https://www.deviantart.com/jepricreations/art/Windows-11-Cursors-Concept-HD-v2-890672103) for a more fitting
cursor. After buying, extract the contents to a known location and go to the version you desire, right click the
`install.inf` file, click install and accept any dialogs that appear.
