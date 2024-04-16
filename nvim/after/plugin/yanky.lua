local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping")

require("yanky").setup
{
    picker =
    {
        select = { action = nil, },
        telescope = { mappings = { i = { ["<CR>"] = mapping.set_register(utils.get_default_register()) }, }, }
    }
}

require("telescope").load_extension("yank_history")

vim.keymap.set("n", "<leader>py", ":Telescope yank_history<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ky", ":YankyClearHistory<CR>", { noremap = true, silent = true })
