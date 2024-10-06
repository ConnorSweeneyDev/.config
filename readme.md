# Windows11Workflow
All my dotfiles, using Neovim with PowerShell Core in the Windows Terminal along with fzf and a
wrapper for it for fast navigation. Additionally, there is a quick setup for Firefox with Tridactyl
and for a Tiling Window Manager using Komorebi with Yasb and AutoHotkey. You will also find a list
of other useful tools at the end.

https://github.com/user-attachments/assets/88be324a-265e-4b93-9800-35db70285a57

*Showcase: An overhaul of the Windows development experience, using a tiling window manager with
workspaces and a status bar rather than a taskbar, many command line utilities, some custom scripts,
a lot of hotkeys and a fully fledged Neovim setup that uses the Windows Terminal.*

# System
The layout of this repository assumes a chronological reading, meaning that dependencies from one
section may carry over to later sections, so it is recommended to install all the previous
dependencies before trying to set up a later section.

### Local Paths to Modules
- LocalState &rightarrow;
  `$Env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_[NUMBER]\LocalState`.
- ahk &rightarrow; `$Env:USERPROFILE\.config\ahk`.
- komorebi &rightarrow; `$Env:USERPROFILE\.config\komorebi`.
- nvim &rightarrow; `$Env:USERPROFILE\.config\nvim`.
- posh &rightarrow; `$Env:USERPROFILE\.config\posh`.
- pwsh &rightarrow; `$Env:USERPROFILE\.config\pwsh`.
- which &rightarrow; `$Env:USERPROFILE\.config\which`.
- yasb &rightarrow; `$Env:USERPROFILE\.config\yasb`.

### Setup
- Ensure "Developer Mode" is turned on in windows settings (Windows + I and then search
  `developer`).
- Ensure you are able to access and use the Windows Store, winget relies on this for certain things.
  If you can't access the store (it's known to be glitchy for some accounts) then you can find
  alternative installs for all dependencies on either
  [Chocolatey](https://chocolatey.org/install#individual) or the dependency's official website.

# Terminal
### Dependencies
- Windows Terminal &rightarrow; Run `winget install --id Microsoft.WindowsTerminal`.
- PowerShell Core (pwsh.exe) &rightarrow; Run `winget install --id Microsoft.Powershell --source
  winget`.
- gsudo &rightarrow; Run `winget install --id gerardog.gsudo`.
- Git &rightarrow; Run `winget install --id Git.Git --source winget`, then run `git config --system
  core.longpaths true`.
- OhMyPosh &rightarrow; Run `winget install JanDeDobbeleer.OhMyPosh`.
- fzf &rightarrow; Run `winget install --id=junegunn.fzf`.
- fd &rightarrow; Run `winget install --id sharkdp.fd --source winget`.
- bat &rightarrow; Run `winget install sharkdp.bat`.

### Setup
- Paste the `$Env:USERPROFILE\.config\pwsh` folder to that location, then run `notepad $PROFILE` and
  paste this line into the file that is opened: `. $Env:USERPROFILE"\.config\pwsh\profile.ps1"`.
  (You may have to create the file first if it doesn't exist).
- Go back to `profile.ps1` and remove the `attend` and `music` functions, as they are specific to
  me. Other than those two functions, skim the rest of the file and remove anything you know you
  won't need - everything is commented so you can be sure of what you're doing.
- To set up gsudo after installing it, run the following commands:
  - `sudo config PowerShellLoadProfile true`.
  - `sudo config CacheMode auto`.
  - `sudo config CacheDuration infinite`.
  - `sudo config LogLevel None`.
- You can use the following aliases in your `$Env:USERPROFILE\.gitconfig` file if you want:
  ```
  [alias]
    i = init
    r = restore
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
  ```
- Paste the `$Env:USERPROFILE\.config\posh` folder to that location and run `oh-my-posh disable
  notice` to stop the annoying update message every so often.
- Install a NerdFont by going [here](https://www.nerdfonts.com/font-downloads) and put the contents
  in `C:\Fonts`, select all and right click then select "Install". You can delete the .ttf files
  from the folder after you've installed them.
- If you want my exact settings including the same font I use (CaskaydiaCove Nerd Font), you can
  replace the following sections of your own `LocalState\settings.json` file with the ones from this
  repository:
  - The entire `actions` section.
  - Everything between the `actions` section and the `profiles` section.
  - The `defaults` section inside of the `profiles` section.
  - Assuming you have it installed, everything inside the PowerShell Core (pwsh.exe) section inside
    the `profiles: list` section, except the `guid` and `source` fields.
  - Everything below the `schemes` section.

  If you don't want to install my font, you can still follow the above list but change the `font:
  face` property inside the `defaults` to the name of the font you have installed. After doing all
  of this, you can tweak other settings to your liking by using the settings gui in Windows
  Terminal.
- Paste the `$Env:USERPROFILE\.config\which` folder to that location and put it in your path.

# Neovim
### Dependencies
- Complete the Terminal section first.
- Microsoft Visual C++ 2015-2022 Redistributable (x64) &rightarrow; Download from
  [here](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170) and
  run the installation wizard.
- Java &rightarrow; Download the compressed archive from
  [here](https://www.oracle.com/java/technologies/downloads/) and place the folder named
  `jdk-[VERSION]` in `C:\Program Files\Java` then add `C:\Program Files\Java\jdk-[VERSION]\bin` to
  your path.
- MinGW &rightarrow; Download from [here](https://winlibs.com/) and put the contents in `C:\MinGW`
  (I recommend 64-bit with POSIX threads for general purpose use). Add `C:\MinGW\bin` to your path.
- Python &rightarrow; Run `winget install --id Python.Python.3.10`.
- NodeJS &rightarrow; Run `winget install OpenJS.NodeJS` and say yes to installing Chocolatey.
- Deno &rightarrow; Run `winget install --id DenoLand.Deno`.
- Yarn &rightarrow; Run `winget install --id Yarn.Yarn`.
- ripgrep &rightarrow; Run `winget install BurntSushi.ripgrep.MSVC`.
- Neovim &rightarrow; Run `winget install neovim --version 0.10.0`.
- Python Provider &rightarrow; Run `pip install pynvim --upgrade`.
- NodeJS Provider &rightarrow; Run `npm install -g neovim`.

### Setup
After setting up the terminal and installing all the dependencies for this section, I recommend
manually recreating the `nvim` folder on your PC rather than just pasting it in, because this will
allow you to single out any unexpected errors as they happen.

You should start with the top level `init.lua` and then `lua\main\init.lua`. Then you can create
`lua\main\remap.lua` and `lua\main\set.lua` and paste the config into each. Now you can create
`lua\main\lazy.lua`, and populate it with only the following lines:
```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.keymap.set("n", "<LEADER>l", "<CMD>Lazy<CR>")
require("lazy").setup
{
}
```
Restart neovim and there should be no error messages.

Now, inside the `.setup` field you can start adding plugins, do so in the following pattern (with
some exceptions):
- Add the line to `lua\main\lazy.lua` and restart neovim.
- If it needs one, add an `after\plugin\[PLUGIN].lua` file for the plugin and restart neovim.

The following plugins require extra or different steps than those outlined above:
- Telescope &rightarrow; This should be installed at the same time as telescope-ui-select,
  `after\plugin\telescope.lua` requires both of these plugins to be installed.
- Leap &rightarrow; This should be installed at the same time as leap-by-word,
  `after\plugin\leap.lua` requires both of these plugins to be installed.
- Treesitter &rightarrow; After following the steps, you should see it compiling languages - don't
  touch your keyboard until this is finished, though it is common to get errors at this point, if
  you do, generally restarting neovim a few times and deleting any directories manually that it says
  it doesn't have permission to delete will let them all figure themselves out. However if you get
  an error along the lines of `[LANGUAGE].so is not a valid Win32 app`, this means either your
  version of MinGW does not match your operating system or treesitter is using the wrong compiler.
  After fixing the issue you can run `:TSInstall [LANGUAGE]` to recompile it.
- Coc &rightarrow; After following the steps, run `:CocInstall coc-diagnostic coc-copilot coc-git
  coc-html coc-tsserver coc-css coc-json coc-xml coc-sql coc-pyright coc-java coc-clangd
  coc-clang-format-style-options` then `:q` to close the dialog once everything is installed. Now
  add `coc-settings.json`, where you should add the path to your java installation instead of my
  one, then restart again. If you don't want one of the listed servers, dont include them or just
  run `:CocUninstall [SERVER]` after the first command. If a language you want is missing, you can
  find it
  [here](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions).
- Copilot &rightarrow; If you don't have a license for Copilot then don't include this plugin. If
  you do, then after following the steps run `:Copilot setup` and follow the instructions.
- Colorscheme &rightarrow; You can use the one that I use, but if you don't want to you will have to
  change the lines in `lua\main\lazy.lua`, `after\plugin\colors.lua` and
  `after\plugin\lualine.lua` accordingly.

You can now add the `after\ftplugin` folder and any files inside it, which are used for language
specific configuration; After that, don't forget to include `after\plugin\buffers.lua`.

The file `buffers.lua` is an optional "plugin", as it can slow down the startup time but will open,
in separate buffers, every file in the specified directory that has any of the file extensions
specified - this can be useful because diagnostics for files that are not open will still be shown
when you toggle the diagnostics window. If you need to close all the buffers except the current one
(when you need to rename symbols, go to references etc.), this file also provides the keybind for
that, and the keybind for re-opening them all again too. It assumes you have coc installed, but if
you don't you can remove the lines that use it.

Finally, you can paste the `mapping-info` folder into the root for safe keeping. All keybinds and
settings can be edited at `lua\main\remap.lua`, `lua\main\set.lua` or the respective
`after\plugin\[PLUGIN].lua` files. Furthermore, all language specific settings can be edited at
`after\ftplugin\[EXTENSION].lua` and language server settings can be edited at `coc-settings.json`.

## Portable Neovim
I also have an extremely minimal setup (one file) that can be cloned and run on any machine
that can run neovim. You can find it [here](https://github.com/ConnorSweeneyDev/nvim-portable), I
only use it when I have to use a remote machine or someone else's computer.

# Firefox with Tridactyl
### Dependencies
- Firefox &rightarrow; Download from [here](https://www.mozilla.org/en-GB/firefox/new/). Install to
  `C:\Program Files\Mozilla Firefox\firefox.exe`.
- Tridactyl &rightarrow; Go
  [here](https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/?utm_source=github.com&utm_content=readme.md)
  on Firefox.

### Setup
First, make firefox your default browser. After that go to Firefox settings and change the
following:
- General &rightarrow; Use recommended performance settings = Off.
- General &rightarrow; Use hardware acceleration when available = Off.
- Home &rightarrow; Homepage and new windows &rightarrow; Custom URLs... &rightarrow; Open a new
  tab, then close it and go to your history, copy the url of that closed tab and paste it into the
  field - it should be of the form `moz-extension://[NUMBERS]/static/newtab.html`.
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

You can go [here](https://github.com/tridactyl/tridactyl?tab=readme-ov-file#highlighted-features) to
view all the most important bindings.

# Tiling Window Manager
### Dependencies
- Komorebi &rightarrow; Run `winget install LGUG2Z.komorebi`.
- Yasb &rightarrow; Run `winget install --id AmN.yasb`.
- AutoHotkey &rightarrow; Run `winget install AutoHotkey.AutoHotkey`.
- ToggleRoundedCorners &rightarrow; Download the portable executable from
  [here](https://github.com/oberrich/win11-toggle-rounded-corners/releases) and rename it to
  `trc.exe`. Place it in `C:\ToggleRoundedCorners` and put that folder in your path.

### Setup
- Run `Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled'
  -Value 1` in PowerShell Core as an admin.
- Open control panel and go to the "Ease of Access Center" then "Make the computer easier to see" -
  enable "Turn off all unnecessary animations (when possible)".
- Press Windows + I and search `taskbar`, go to taskbar settings and turn on "Automatically hide the
  taskbar" under the taskbar behaviours.
- Search `multitasking` and turn off everything under the snap windows section except "Show my
  snapped windows when I hover over taskbar apps... ...when I press Alt+Tab".
- Add the files in this repository's `komorebi` folder to `$Env:USERPROFILE\.config\komorebi` on
  your machine. In `komorebi.json` ensure that the correct amount of monitors are configured and
  that any absolute paths are valid.
- Replace the files at `$Env:USERPROFILE\.config\yasb` with the ones from this repository. Add
  `$Env:USERPROFILE\AppData\Local\Yasb` to your path.
- Create the `$Env:USERPROFILE\.config\ahk` folder and paste the file from this repository into it.
  Ensure you configure anything specific to monitor resolution. Right click `wm.ahk` and create a
  shortcut, then rename it to just `wm` and create a copy of it, one each should be moved to
  `C:\ProgramData\Microsoft\Windows\Start Menu\Programs` and that folder's sub-directory `Startup`.
  Now it will be run at startup and is accessible from the start menu in case you need to restart
  the manager, and all three processes can be killed from the task manager.
- Restart your PC.

Keybinds and commands to run on startup can be configured in `wm.ahk`, the status bar can be
configured in the Yasb `config.yaml` and `styles.css` files, and the window manager can be
configured by Komorebi's `komorebi.json`, `applications.yaml` and any `*.json` files for custom
layouts.

# Other Useful Tools
VimForVoyager &rightarrow; Go [here](https://github.com/ConnorSweeneyDev/VimForVoyager) and follow
the setup guide for a native Vim toggle for QMK keyboards.

PowerToys &rightarrow; Run `winget install Microsoft.PowerToys --source winget` - enable Run at
startup - my favourite tools are:
- Run with an activation shortcut of `shift+backspace`, input smoothing disabled, clear previous
  query on launch enabled, preferred monitor primary, all plugins off except "Program" - this
  behaves just like the windows run dialog but without cortana, searching the internet or any other
  annoyances.
- Color Picker with an activation shortcut of `win+shift+c` and HEX, RGB and VEC4 enabled.
- Mouse Jump with an activation shortcut of `win+shift+d` and a max size of `1200x900`.
- Screen Ruler with an activation shortcut of `win+shift+p`.
- Text Extractor with an activation shortcut of `win+shift+t`.
- File Locksmith enabled.

SysInternals &rightarrow; Download from
[here](https://learn.microsoft.com/en-us/sysinternals/downloads/) and choose the executables that
you want - the only one I use is ZoomIt with the following settings:
- Run ZoomIt when Windows starts and Show tray icon both enabled.
- Zoom on `ctrl+/` with animate zoom in and zoom out disabled.
- Draw on `ctrl+'`.
- Record on `ctrl+;`.

Visual Studio 2022 &rightarrow; Download from [here](https://visualstudio.microsoft.com/vs/) and go
through the installation wizard.

Make &rightarrow; Run `winget install --id ezwinports.make`.

CMake &rightarrow; Run `winget install --id Kitware.CMake`.

Dependencies &rightarrow; Download from [here](https://github.com/lucasg/Dependencies) and put the
contents in `C:\Dependencies`, make that folder is an environment variable, then right click
`DependenciesGui.exe` and select "Create shortcut" and rename it to `Dependencies`, then move that
to `C:\ProgramData\Microsoft\Windows\Start Menu\Programs`.

Everything &rightarrow; Download the portable zip from [here](https://www.voidtools.com/) and put
the contents in `C:\Everything`. Right click `Everything.exe` and select "Create shortcut", then
rename it to `Everything` and place this shortcut in `C:\ProgramData\Microsoft\Windows\Start
Menu\Programs`.

Cutter &rightarrow; Download from [here](https://github.com/rizinorg/cutter/releases) and put the
contents in `C:\Cutter`. Right click `cutter.exe` and select "Create shortcut", then rename it to
`Cutter` and place this shortcut in `C:\ProgramData\Microsoft\Windows\Start Menu\Programs`.

Portal &rightarrow; Run `winget install SpatiumPortae.portal`, go
[here](https://github.com/SpatiumPortae/portal) for instructions.

Mp3tag &rightarrow; Download from [here](https://www.mp3tag.de/en/download.html) and go through the
installation wizard.

scc &rightarrow; As an admin, run `choco install scc` - details can be found
[here](https://github.com/boyter/scc).

Windows11CursorConceptV2.2 &rightarrow; Go
[here](https://www.deviantart.com/jepricreations/art/Windows-11-Cursors-Concept-HD-v2-890672103) for
a more fitting cursor. After buying, extract the contents to a known location and go to the version
you desire, right click the `install.inf` file, click install and accept any dialogs that appear.
