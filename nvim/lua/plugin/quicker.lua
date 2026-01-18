require("bqf").setup({ preview = { border = "none", win_height = 1000 } })
local quicker = require("quicker")
quicker.setup({
  keys = {
    {
      ">",
      function() quicker.expand({ before = 2, after = 2, add_to_existing = true }) end,
      { desc = "Expand quickfix entry" },
    },
    {
      "<",
      function() quicker.collapse() end,
      { desc = "Collapse quickfix entry" },
    },
  },
  highlight = { load_buffers = true },
})
vim.keymap.set("n", "<LEADER>qt", function() Quickfix_util.toggle(quicker) end, { desc = "Toggle quickfix list" })
vim.keymap.set(
  "n",
  "<LEADER>qs",
  function() Quickfix_util.literal_search() end,
  { desc = "Search project for literal search term" }
)
vim.keymap.set(
  "n",
  "<LEADER>qw",
  function() Quickfix_util.literal_word() end,
  { desc = "Search project for word under cursor" }
)
vim.keymap.set(
  "n",
  "<LEADER>qW",
  function() Quickfix_util.literal_full_word() end,
  { desc = "Search project for WORD under cursor" }
)
vim.keymap.set(
  "v",
  "<LEADER>q",
  function() Quickfix_util.literal_selection() end,
  { desc = "Search project for selection" }
)
vim.keymap.set(
  "n",
  "<LEADER>qg",
  function() Quickfix_util.grep_search() end,
  { desc = "Search project for grep search term" }
)
