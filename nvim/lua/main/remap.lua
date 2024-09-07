vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<nop>")
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<LEADER>w", "<CMD>w<CR>")
vim.keymap.set("n", "<LEADER>tw", "<CMD>set wrap!<CR>")

-- These bindings require the scripts folder to work
vim.keymap.set("n", "<C-f>n", "<CMD>!wt --window 0 -p \"PowerShell\" pwsh -NoExit -Command \"nw\"<CR>")
vim.keymap.set("n", "<C-f>c", "<CMD>!wt --window 0 -p \"PowerShell\" pwsh -NoExit -Command \"cw\"<CR>")
vim.keymap.set("n", "<C-f>e", "<CMD>!wt --window 0 -p \"PowerShell\" pwsh -NoExit -Command \"ew\"<CR>")
vim.keymap.set("n", "<C-t>n", "<CMD>!wt --window 0 -p \"PowerShell\"<CR>")
vim.keymap.set("n", "<C-t>c", "<CMD>!wt --window 0 -p \"PowerShell\" pwsh -NoExit -Command \"cd " .. vim.fn.getcwd() .. "\"<CR>")
vim.keymap.set("n", "<C-w>n", "<CMD>!wt<CR>")
vim.keymap.set("n", "<C-w>c", "<CMD>!wt pwsh -NoExit -Command \"cd " .. vim.fn.getcwd() .. "\"<CR>")
vim.keymap.set("n", "<C-w>e", "<CMD>!e<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "gJ", "mzgJ`z")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set({"n", "v"}, "j", "(v:count ? 'j' : 'gj')", {expr = true})
vim.keymap.set({"n", "v"}, "k", "(v:count ? 'k' : 'gk')", {expr = true})

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "#", "#zzzv")

vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")

vim.keymap.set({"n", "v"}, "<LEADER>y", [["+y]])
vim.keymap.set("n", "<LEADER>Y", [["+Y]])
vim.keymap.set("x", "<LEADER>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<LEADER>d", [["_d]])
vim.keymap.set({"n", "v"}, "<LEADER>c", [["_c]])
vim.keymap.set({"n", "v"}, "<LEADER>x", [["_x]])

vim.keymap.set("n", "<LEADER>s", [[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>]])
vim.keymap.set("v", "<LEADER>s", "\"hy:%s/<C-r>h/<C-r>h/g<Left><Left>")
vim.keymap.set("v", "<C-s>", ":s//g<Left><Left>")
vim.keymap.set("v", "<C-n>", ":normal ")

-- Will specifically search in files in the program directory
vim.keymap.set("n", "<LEADER>qg", ":silent grep  program<Left><Left><Left><Left><Left><Left><Left><Left>")
vim.keymap.set("n", "<LEADER>qo", "<CMD>copen<CR>")
vim.keymap.set("n", "<LEADER>qr", ":cdo s//g<Left><Left>")
vim.keymap.set("n", "<LEADER>qf", "\"+yiw:silent grep <C-r><C-w> program<CR><CMD>copen<CR>")
vim.keymap.set("v", "<LEADER>qf", "\"+ygv\"hy:silent grep <C-r>h program<CR><CMD>copen<CR>")

vim.keymap.set("n", "<LEADER>v", "<CMD>!./script/clean.bat<CR>")
vim.keymap.set("n", "<LEADER>b", "<CMD>!./script/build.bat<CR>")
vim.keymap.set("n", "<LEADER>n", "<CMD>!./script/run.bat<CR>")
vim.keymap.set("n", "<LEADER>m", "<CMD>!./script/debug.bat<CR>")
