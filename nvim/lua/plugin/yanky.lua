require("telescope").load_extension("yank_history")
require("yanky").setup({
  picker = {
    select = { action = nil },
    telescope = {
      mappings = {
        i = {
          ["<CR>"] = require("yanky.telescope.mapping").set_register(require("yanky.utils").get_default_register()),
        },
      },
    },
  },
})
vim.keymap.set("n", "<LEADER>py", "<CMD>Telescope yank_history<CR>", { noremap = true, silent = true }, { desc = "Open Yanky" })
vim.keymap.set("n", "<LEADER>ky", "<CMD>YankyClearHistory<CR>", { noremap = true, silent = true }, { desc = "Clear Yank History" })
