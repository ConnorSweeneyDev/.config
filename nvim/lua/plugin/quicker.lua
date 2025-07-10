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
