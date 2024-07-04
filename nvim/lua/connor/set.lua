vim.g.netrw_banner = 0

vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.opt.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
vim.opt.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "no"
vim.opt.colorcolumn = "100"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.textwidth = 100
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:remove("c")

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = false
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.termguicolors = true

vim.opt.isfname:append("@-@")
vim.opt.updatetime = 300
