vim.g.undotree_DiffCommand = "FC"
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_DiffAutoOpen = 0
vim.keymap.set("n", "<LEADER>tu", "<CMD>UndotreeToggle<CR>", { desc = "Open Undo Tree" })
