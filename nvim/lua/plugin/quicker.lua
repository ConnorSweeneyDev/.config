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
  higlight = { load_buffers = true },
})
vim.keymap.set("n", "<LEADER>tq", function() quicker.toggle() end, { desc = "Toggle quickfix list" })
vim.keymap.set(
  "n",
  "<LEADER>qg",
  function() Quickfix_util.grep_search(General_util.find_target_directory()) end,
  { desc = "Grep project for search term" }
)
vim.keymap.set(
  "n",
  "<LEADER>qw",
  function() Quickfix_util.grep_word(General_util.find_target_directory()) end,
  { desc = "Grep project for word under cursor" }
)
vim.keymap.set(
  "n",
  "<LEADER>qW",
  function() Quickfix_util.grep_full_word(General_util.find_target_directory()) end,
  { desc = "Grep project for WORD under cursor" }
)
vim.keymap.set(
  "v",
  "<LEADER>q",
  function() Quickfix_util.grep_selection(General_util.find_target_directory()) end,
  { desc = "Grep project for selection" }
)
