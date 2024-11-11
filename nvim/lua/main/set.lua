g.netrw_banner = 0
opt.shell = "pwsh.exe"
opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSStyle.Formatting.Error = '';$PSStyle.Formatting.ErrorAccent = '';$PSStyle.Formatting.Warning = '';$PSStyle.OutputRendering = 'PlainText';"
opt.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
opt.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
opt.shellquote = ""
opt.shellxquote = ""
opt.nu = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.colorcolumn = "120"
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.linebreak = true
opt.scrolloff = 1000
opt.textwidth = 120
opt.formatoptions:remove("t")
opt.formatoptions:remove("c")
opt.autoread = true
opt.swapfile = false
opt.undofile = true
opt.backup = false
opt.writebackup = false
opt.ignorecase = false
opt.hlsearch = false
opt.incsearch = true
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
opt.termguicolors = true
opt.isfname:append("@-@")
opt.updatetime = 300
api.nvim_create_autocmd("VimResized", {command = "wincmd ="})
