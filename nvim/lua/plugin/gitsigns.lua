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
    vim.keymap.set({ "n", "v" }, "]g", function() gitsigns.nav_hunk("next") end, { buffer = bufnr, desc = "Next hunk" })
    vim.keymap.set({ "n", "v" }, "[g", function() gitsigns.nav_hunk("prev") end, { buffer = bufnr, desc = "Prev hunk" })
    vim.keymap.set("n", "<LEADER>gd", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
  end,
})
