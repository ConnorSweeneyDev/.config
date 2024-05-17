vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<LEADER>pv", "<CMD>Oil<CR>")
vim.keymap.set("n", "<C-f>", "<CMD>!wt --window 0 -p \"PowerShell\" pwsh -NoExit -Command \"nw\"<CR>")
vim.keymap.set("n", "<C-t>", "<CMD>!wt --window 0 -p \"PowerShell\"<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

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

vim.keymap.set("x", "<LEADER>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<LEADER>y", [["+y]])
vim.keymap.set("n", "<LEADER>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<LEADER>d", [["_d]])
vim.keymap.set({"n", "v"}, "<LEADER>c", [["_c]])
vim.keymap.set({"n", "v"}, "<LEADER>x", [["_x]])

vim.keymap.set("n", "<LEADER>s", [[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>]])
vim.keymap.set("v", "<LEADER>s", "\"hy:%s/<C-r>h/<C-r>h/g<Left><Left>")
vim.keymap.set("v", "<C-s>", ":s//g<Left><Left>")
vim.keymap.set("v", "<C-n>", ":normal ")

vim.keymap.set("n", "<LEADER>qg", ":silent grep  program<Left><Left><Left><Left><Left><Left><Left><Left>")
vim.keymap.set("n", "<LEADER>qr", ":cdo s//g<Left><Left>")
vim.keymap.set("n", "<LEADER>qo", "<CMD>copen<CR>")

vim.keymap.set("n", "<LEADER>v", "<CMD>!./system/clean.bat<CR>")
vim.keymap.set("n", "<LEADER>b", "<CMD>!./system/build.bat<CR>")
vim.keymap.set("n", "<LEADER>n", "<CMD>!./system/run.bat<CR>")
vim.keymap.set("n", "<LEADER>m", "<CMD>!./system/debug.bat<CR>")
