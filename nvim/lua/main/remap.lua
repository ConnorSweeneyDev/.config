vim.g.mapleader = " "
vim.keymap.set("n", " ", "<NOP>")
vim.keymap.set("n", "<C-f>", "<nop>")

vim.keymap.set("n", "<LEADER>w", "<CMD>w<CR>")
vim.keymap.set("n", "<LEADER>tw", "<CMD>set wrap!<CR>")

-- These bindings require the which fzf wrapper to work
vim.keymap.set("n", "<C-w>e", "<CMD>!e<CR>")
vim.keymap.set("n", "<C-w>n", "<CMD>!wn<CR>")
vim.keymap.set("n", "<C-t>n", "<CMD>!tn<CR>")
vim.keymap.set("n", "<C-w>c", "<CMD>!wc<CR>")
vim.keymap.set("n", "<C-t>c", "<CMD>!tc<CR>")
vim.keymap.set("n", "<C-f>c", "<CMD>!fc<CR>")
vim.keymap.set("n", "<C-f>e", "<CMD>!fe<CR>")
vim.keymap.set("n", "<C-f>n", "<CMD>!fn<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "gJ", "mzgJ`z")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set({"n", "v"}, "j", "gj")
vim.keymap.set({"n", "v"}, "k", "gk")

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

vim.keymap.set("n", "<LEADER>s", ":%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>")
vim.keymap.set("n", "<C-s>", ":%s//g<Left><Left>")
vim.keymap.set("v", "<LEADER>s", "\"hy:%s/<C-r>h/<C-r>h/g<Left><Left>")
vim.keymap.set("v", "<C-s>", ":s//g<Left><Left>")
vim.keymap.set("v", "<C-n>", ":normal ")

-- Will specifically search in files in the program directory
vim.keymap.set("n", "<LEADER>qg", ":silent grep  program<C-Left><Left>")
vim.keymap.set("n", "<LEADER>qo", "<CMD>copen<CR>")
vim.keymap.set("n", "<LEADER>qr", ":cdo s//g<Left><Left>")
vim.keymap.set("n", "<LEADER>qw", "\"+yiw:silent grep <C-r><C-w> program<CR><CMD>copen<CR>")
vim.keymap.set("n", "<LEADER>qW", "\"+yiw:silent grep <C-r><C-a> program<CR><CMD>copen<CR>")
vim.keymap.set("v", "<LEADER>q", "\"+ygv\"hy:silent grep <C-r>h program<CR><CMD>copen<CR>")

-- Change to your liking based on the terminal/project you are using
vim.keymap.set("n", "<LEADER>v", "<CMD>!./script/clean.bat -wezterm<CR>")
vim.keymap.set("n", "<LEADER>b", "<CMD>!./script/build.bat -wezterm<CR>")
vim.keymap.set("n", "<LEADER>n", "<CMD>!./script/run.bat -wezterm<CR>")
vim.keymap.set("n", "<LEADER>m", "<CMD>!./script/debug.bat -wezterm<CR>")
