vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-f>", ":!pwsh -c \"wt --window 0 -p \"PowerShell\" pwsh -NoExit -c \"cw\"\"<CR><CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>c", [["_c]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])
vim.keymap.set("v", "<leader>s", "\"hy:%s/<C-r>h//g<Left><Left>")
vim.keymap.set("v", "<C-s>", ":s//g<Left><Left>")

vim.keymap.set("n", "<leader>ag", ":silent grep  prog/<Left><Left><Left><Left><Left><Left>")
vim.keymap.set("n", "<leader>og", ":copen<CR>")
vim.keymap.set("n", "<leader>rg", ":cdo s//g<Left><Left>")

vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)
vim.keymap.set("n", "<leader>v", ":!clean.bat<CR><CR>")
vim.keymap.set("n", "<leader>b", ":!build.bat<CR><CR>")
vim.keymap.set("n", "<leader>n", ":!run.bat<CR><CR>")
vim.keymap.set("n", "<leader>m", ":!debug.bat<CR><CR>")
