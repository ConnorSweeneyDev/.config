vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.opt.showtabline = 0
vim.opt.showmode = false
vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding"
  .. "=[System.Text.Encoding]::UTF8;$PSStyle.Formatting.Error = '';$PSStyle.Formatting.ErrorAccent = '';"
  .. "$PSStyle.Formatting.Warning = '';$PSStyle.OutputRendering = 'PlainText';"
vim.opt.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
vim.opt.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""
vim.opt.cmdheight = 1
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.textwidth = Language_util.set_textwidth(120)
vim.opt.colorcolumn = tostring(Language_util.textwidth)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.scrolloff = 0
vim.opt.pumheight = 16
vim.opt.winborder = "none"
vim.opt.list = true
vim.opt.listchars = { tab = "▏ ", trail = "·", extends = "»", precedes = "«" }
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:remove("c")
vim.opt.isfname:append("@-@")
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.ignorecase = false
vim.opt.smartcase = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.api.nvim_create_autocmd("VimResized", { command = "wincmd =" })
vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter", "WinEnter" }, { command = "normal! zz" })
