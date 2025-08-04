require("yanky").setup({
  picker = {
    select = { action = require("yanky.picker").actions.set_register(require("yanky.utils").get_default_register()) },
  },
})
vim.keymap.set(
  "n",
  "<LEADER>py",
  "<CMD>YankyRingHistory<CR>",
  { noremap = true, silent = true, desc = "Open Yanky" }
)
vim.keymap.set(
  "n",
  "<LEADER>ky",
  "<CMD>YankyClearHistory<CR>",
  { noremap = true, silent = true, desc = "Clear Yank History" }
)
