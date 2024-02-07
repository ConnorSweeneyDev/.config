local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({
    settings = {
        save_on_toggle = true
    }
})
-- REQUIRED

vim.keymap.set("n", "<C-e>",
    function() harpoon.ui:toggle_quick_menu(
        harpoon:list(),
        {
            title = " Harpoon ",
            title_pos = "left",
            border = "rounded",
        }
    ) end
)

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>z", function() harpoon:list():remove() end)
vim.keymap.set("n", "<C-z>", function() harpoon:list():clear() end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-t>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-g>", function() harpoon:list():next() end)
