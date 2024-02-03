vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-f>", ":!pwsh -Command \"wt --window 0 -p \"PowerShell\" pwsh -c \"nw\"\"<CR><CR>")

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

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
vim.keymap.set("n", "<leader>b", ":!build.bat<CR><CR>")
vim.keymap.set("n", "<leader>v", ":!debug.bat<CR><CR>")
vim.keymap.set("n", "<leader>n", ":!run.bat<CR><CR>")

vim.keymap.set("i", "<C-h>", "<Esc>$i<Right>();<Left><Left>")
vim.keymap.set("i", "<C-j>", "<Esc>$i<Right>()<Left>")
vim.keymap.set("i", "<C-k>", "<Esc>$i<Right><CR>{<CR><CR>}<Up>a<Esc>v=$i<Del>")
vim.keymap.set("i", "<C-l>", "<Esc>$i<Right><CR>{<CR><CR>};<Up>a<Esc>v=$i<Del>")
