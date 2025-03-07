local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping")
require("yanky").setup({
	picker = {
		select = { action = nil },
		telescope = { mappings = { i = { ["<CR>"] = mapping.set_register(utils.get_default_register()) } } },
	},
})
require("telescope").load_extension("yank_history")
map("n", "<LEADER>py", "<CMD>Telescope yank_history<CR>", { noremap = true, silent = true })
map("n", "<LEADER>ky", "<CMD>YankyClearHistory<CR>", { noremap = true, silent = true })
