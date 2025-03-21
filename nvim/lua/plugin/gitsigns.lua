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
    Map("n", "]g", function() gitsigns.nav_hunk("next") end, { buffer = bufnr })
    Map("n", "[g", function() gitsigns.nav_hunk("prev") end, { buffer = bufnr })
  end,
})
