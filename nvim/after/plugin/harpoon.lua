local harpoon = require("harpoon")
harpoon:setup{ settings = { save_on_toggle = true } }

vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), {title = " Harpoon ", title_pos = "left", border = "rounded"}) end)

vim.keymap.set("n", "<LEADER>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<LEADER>z", function() harpoon:list():remove() end)
vim.keymap.set("n", "<C-z>", function() harpoon:list():clear() end)

vim.keymap.set("n", "<C-y>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-g>", function() harpoon:list():next() end)
