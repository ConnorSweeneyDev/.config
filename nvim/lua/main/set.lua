G.mapleader = " "
G.netrw_banner = 0
Opt.showtabline = 0
Opt.shell = "pwsh.exe"
Opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding"
  .. "=[System.Text.Encoding]::UTF8;$PSStyle.Formatting.Error = '';$PSStyle.Formatting.ErrorAccent = '';"
  .. "$PSStyle.Formatting.Warning = '';$PSStyle.OutputRendering = 'PlainText';"
Opt.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
Opt.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
Opt.shellquote = ""
Opt.shellxquote = ""
Opt.nu = true
Opt.relativenumber = true
Opt.signcolumn = "yes"
Opt.textwidth = Language_util.set_textwidth(120)
Opt.colorcolumn = tostring(Language_util.textwidth)
Opt.tabstop = 2
Opt.softtabstop = 2
Opt.shiftwidth = 2
Opt.expandtab = true
Opt.smartindent = true
Opt.wrap = false
Opt.linebreak = true
Opt.scrolloff = 0
Opt.pumheight = 16
Opt.winborder = "none"
Opt.list = true
Opt.listchars = { tab = "▏ ", trail = "·", extends = "»", precedes = "«" }
Opt.formatoptions:remove("t")
Opt.formatoptions:remove("c")
Opt.isfname:append("@-@")
Opt.autoread = true
Opt.swapfile = false
Opt.undofile = true
Opt.backup = false
Opt.writebackup = false
Opt.ignorecase = false
Opt.hlsearch = false
Opt.incsearch = true
Opt.grepprg = "rg --vimgrep"
Opt.grepformat = "%f:%l:%c:%m"
Opt.termguicolors = true
Opt.updatetime = 300
Api.nvim_create_autocmd("VimResized", { command = "wincmd =" })
Api.nvim_create_autocmd({ "CursorMoved", "BufEnter", "WinEnter" }, { command = "normal! zz" })
