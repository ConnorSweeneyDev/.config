local gitsigns = require("gitsigns")
gitsigns.setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▎" },
    topdelete = { text = "▎" },
    changedelete = { text = "▎" },
  },
  signs_staged_enable = false,
  on_attach = function(bufnr)
    Map("n", "]g", function() gitsigns.nav_hunk("next") end, { buffer = bufnr, desc = "Next hunk" })
    Map("n", "[g", function() gitsigns.nav_hunk("prev") end, { buffer = bufnr, desc = "Previous hunk" })
    Map("n", "<LEADER>gd", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
  end,
})
