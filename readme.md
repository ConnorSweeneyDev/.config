# Welcome
These are all my Windows dotfiles and how to set them up, using Wezterm with Neovim in PowerShellCore along with fzf.
Additionally there's a setup for a Tiling Window Manager using Komorebi, Yasb and AutoHotkey, and a Tridactyl setup for
Firefox. You will also find a list of other useful tools at the end.

https://github.com/user-attachments/assets/a3e978a1-b440-4f01-ad9c-3e6b171276df

# System
> [!NOTE]
> Every folder in this repository is located locally at `$Env:USERPROFILE\.config`.

### Setup
- Go to the "For Developers" section of the Windows settings and do the following:
  - Ensure "Developer Mode" is turned on.
  - Enable "Show hidden and system files" and "Show file extensions" under "File Explorer".
  - Enable local powershell scripts to run without signing under "PowerShell".
  - Enable Sudo.
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
- Git &rightarrow; Run `winget install --id Git.Git --source winget`.
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
- Run `git config --system core.longpaths true` and ensure that `[PATH_TO_GIT]\bin` is in your path. After that you can
  use the following configuration in your `$Env:USERPROFILE\.gitconfig` file if you want:
  ```
  [core]
    autocrlf = true
    editor = nvim
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
- MinGW &rightarrow; Download from [here](https://winlibs.com/) and put the contents in `C:\Program Files\MinGW` (I
  recommend 64-bit with POSIX threads for general purpose use). Add `C:\Program Files\MinGW\bin` to your path.
- Make &rightarrow; Run `winget install --id ezwinports.make`.
- CMake &rightarrow; Run `winget install --id Kitware.CMake`.
- Python &rightarrow; Run `winget install --id Python.Python.3.10`.
- NodeJS &rightarrow; Run `winget install OpenJS.NodeJS`.
- ripgrep &rightarrow; Run `winget install BurntSushi.ripgrep.MSVC`.
- Neovim &rightarrow; Run `winget install neovim --version 0.11.0`.
- Python Provider &rightarrow; Run `pip install pynvim --upgrade`.
- NodeJS Provider &rightarrow; Run `npm install -g neovim`.

### Setup
After completing the dependencies for this section, I recommend manually recreating `nvim` on your machine rather than
just pasting it in, because this will allow you to single out any unexpected errors as they happen.

You should start with the top level `init.lua` and then `lua\main\init.lua`. Then you can create `lua\main\rename.lua`,
`lua\main\util.lua`, `lua\main\set.lua` and `lua\main\map.lua` and paste the config into each. `set.lua` is for global
settings, `map.lua` is for global keybinds and `util.lua` is for helper functions used throughout the configuration,
designed to remove the need for visible logic in any configuration files. The `rename.lua` file is just for shortening
commonly used lua functions.

Now you can create `lua\main\lazy.lua`, and populate it with only the following lines:
```lua
Lazy_util.bootstrap()
Map("n", "<LEADER>l", "<CMD>Lazy<CR>", { desc = "Open Lazy" })
require("lazy").setup({})
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
  - plenary.nvim &rightarrow; Required by telescope.nvim and neogit.
  - nui.nvim &rightarrow; Required by noice.nvim.
  - nvim-web-devicons &rightarrow; Required by most plugins that use icons.
- Telescope &rightarrow; This should be installed at the same time as telescope-fzf-native.nvim and
  telescope-ui-select.nvim, `lua\plugin\telescope.lua` requires all three of these plugins to be installed.
- Yanky &rightarrow; This plugin requires telescope to be installed, so make sure to do that first.
- Colorscheme &rightarrow; vscode.nvim's plugin file is is `lua\plugin\colors.lua`. You don't have to use that
  cholorscheme, but the file assumes you are and `lua\plugin\lualine.lua` is also set up to use the vscode colorscheme
  so you'll need to change those as well as the `lua\main\lazy.lua` file if you want a different scheme.
- Treesitter &rightarrow; After following the pattern, you should see it compiling languages - don't touch your keyboard
  until this is finished, though it is common to get errors at this point, if you do, generally restarting neovim a few
  times and deleting any directories manually that it says it doesn't have permission to delete will let them all figure
  themselves out. However if you get an error along the lines of `[LANGUAGE].so is not a valid Win32 app`, this means
  either your version of MinGW does not match your operating system or treesitter is using the wrong compiler for that
  specific language. After fixing the issue you can run `:TSInstall [LANGUAGE]` to recompile it.
- Noice &rightarrow; This should be installed at the same time as notify.nvim.
- LSP &rightarrow; All lsp-related (mason.nvim, blink.cmp and trouble.nvim) plugins should be installed at the same time
  as eachother - the corresponding plugin files are `lua\plugin\blink.lua`, `lua\plugin\trouble.lua`,
  `lua\plugin\mason.lua` and `lua\plugin\lsp.lua`. After following the pattern, you should see it downloading all the
  language servers and formatters specified in the mason file - view all the available downloads by running `:Mason`.
- Neogit &rightarrow; This should be installed at the same time as diffview.nvim.
- Supermaven &rightarrow; If you don't have a subscription, you can still use it by running `:SupermavenUseFree` when
  prompted, otherwise you can follow the instructions to use it with a subscription.

After all of that, don't forget to include these files that are not tied to any plugins if you want them:
- `lua\plugin\language.lua` is the file this configuration uses to set up language specific settings and mappings.
- `lua\plugin\buffers.lua` is optional as it can slow down the startup time but will open, in separate buffers, every
  file in the specified directories that has any of the file extensions specified - this can be useful for certain
  language servers. If you need to close all the buffers except the current one, this file also provides the keybind for
  that, and the keybind for re-opening them all again too.

> [!TIP]
> All global keybinds and settings can be edited at `lua\main\map.lua`, `lua\main\set.lua` or the respective
> `lua\plugin\[PLUGIN].lua` files and you can go into deeper detail inside `lua\main\util.lua`. Furthermore, all
> language specific settings and mappings can be edited at `lua\plugin\language.lua`.

> [!NOTE]
> I also have an extremely minimal setup (one file) that can be cloned and run on any machine that can run neovim. You
> can find it [here](https://github.com/ConnorSweeneyDev/nvim-portable), I only use it when I have to use a remote
> machine or someone else's computer.

# Tiling Window Manager
### Dependencies
- Komorebi &rightarrow; Run `winget install LGUG2Z.komorebi`.
- Yasb &rightarrow; Run `winget install --id AmN.yasb`.
- AutoHotkey &rightarrow; Run `winget install AutoHotkey.AutoHotkey`.
- ToggleRoundedCorners &rightarrow; Download the portable executable from
  [here](https://github.com/oberrich/win11-toggle-rounded-corners/releases) and rename it to `trc.exe`. Place it in
  `C:\Program Files\ToggleRoundedCorners` and put that folder in your path.

### Setup
- Run `Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1` in
  PowerShellCore as an admin.
- Open control panel and go to the "Ease of Access Center" then "Make the computer easier to see" - enable "Turn off all
  unnecessary animations (when possible)".
- Press Windows + I and search `taskbar`, go to taskbar settings and turn on "Automatically hide the taskbar" under the
  taskbar behaviours.
- Search `multitasking` and turn off "Snap windows".
- Paste `komorebi` into your config. In `komorebi.json` ensure that the correct amount of monitors are configured.
- Paste `yasb` into your config. Add `$Env:USERPROFILE\AppData\Local\Yasb` to your path.
- Paste `ahk` into your config. Right click `wm.ahk` and create a shortcut, then rename that shortcut to just `wm` and
  create a copy of it, one should be moved to `C:\ProgramData\Microsoft\Windows\Start Menu\Programs` and the other to
  that folder's sub-directory `Start-up`. Now it will be run at startup and is accessible from the start menu in case
  you need to restart the manager, and all three processes can be killed from the task manager.
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
- Home &rightarrow; Homepage and new windows &rightarrow; Custom URLs... &rightarrow; Open a new tab, then close it and
  go to your history, copy the url of that closed tab and paste it into the field - it should be of the form
  `moz-extension://[NUMBERS]/static/newtab.html`.
- Search &rightarrow; Default search engine = Google.
- Now go to the url `about:config` and search for `full-screen-api.transition-duration.enter` and
  `full-screen-api.transition-duration.leave` and change both to `0 0` for quicker transitions when fullscreening.
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

PowerToys &rightarrow; Run `winget install Microsoft.PowerToys --source winget` and enable "Run at startup" - my
favourite tools are:
- Run with an activation shortcut of `shift+backspace`, input smoothing disabled, clear previous query on launch
  enabled, preferred monitor primary, all plugins off except "Program" and "Windows System Commands" - this behaves just
  like the windows run dialog but without cortana, searching the internet or any other annoyances and the ability to
  type shutdown, restart, etc.
- Color Picker with an activation shortcut of `win+shift+c` and HEX, RGB and VEC4 enabled.
- Mouse Jump with an activation shortcut of `win+shift+d` and a max size of `1600x1200`.
- Screen Ruler with an activation shortcut of `win+shift+p` and default measure style of `Spacing`.
- Text Extractor with an activation shortcut of `win+shift+t`.
- File Locksmith enabled.

Visual Studio 2022 &rightarrow; Download from [here](https://visualstudio.microsoft.com/vs/) and go through the
installation wizard. You can install the extensions "VsVim 2022" and "Clang Power Tools 2022" from the marketplace. Then
you can use the `vs2022/Neovim.vssettings` file to import my recommended settings, and also put the `vs2022/.vimrc` file
in your `$Env:USERPROFILE` folder and restart VS to get some good vim mode bindings. The Clang Power Tools extension is
useful for generating compile_commands.json files for neovim - the `vs2022/ClangPowerToolsFlags.json` file contains the
flags I personally add for warnings.

Dependencies &rightarrow; Download from [here](https://github.com/lucasg/Dependencies) and put the contents in
`C:\Program Files\Dependencies`, make that folder is an environment variable, then right click `DependenciesGui.exe` and
select "Create shortcut" and rename it to `Dependencies`, then move that to `C:\ProgramData\Microsoft\Windows\Start
Menu\Programs`.

WinLister &rightarrow; Go [here](https://www.nirsoft.net/utils/winlister.html) and click "Download WinLister 64-bit",
move the executable to `C:\Program Files\WinLister`, then right click `winlister.exe` and select "Create shortcut", then
rename it to `WinLister` and place this shortcut in `C:\ProgramData\Microsoft\Windows\Start Menu\Programs`.

Everything &rightarrow; Download the portable zip from [here](https://www.voidtools.com/) and put the contents in
`C:\Program Files\Everything`. Right click `Everything.exe` and select "Create shortcut", then rename it to `Everything`
and place this shortcut in `C:\ProgramData\Microsoft\Windows\Start Menu\Programs`.

Mp3tag &rightarrow; Download from [here](https://www.mp3tag.de/en/download.html) and go through the installation wizard.

Better Cursor &rightarrow; Go [here](https://jepricreations.com) for a more fitting cursor. After buying, extract the
contents to a known location and go to the version you desire, right click the `install.inf` file, click install and
accept any dialogs that appear.
