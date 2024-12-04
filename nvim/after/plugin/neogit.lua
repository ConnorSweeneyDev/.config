require("neogit").setup {
  disable_hint = true,
  disable_context_highlighting = true,
  disable_signs = true,
  graph_style = "unicode",
  highlight = {
    italic = false,
    bold = true,
    underline = false
  },
  kind = "replace",
  disable_line_numbers = false,
  disable_relative_line_numbers = false,
  commit_editor = {
    kind = "tab",
    show_staged_diff = true,
    staged_diff_split_kind = "split",
    spell_check = true
  },
  commit_view = {
    kind = "vsplit",
    verify_commit = false
  }
}
map("n", "<LEADER>gs", function() neogit_util.open_status_menu() end)
map("n", "<LEADER>gp", "<CMD>Neogit pull<CR>")
map("n", "<LEADER>gr", "<CMD>!g restore %<CR>")
map("n", "<LEADER>gR", "<CMD>!g restore .<CR>")
map("n", "<LEADER>gg", "<CMD>diffget<CR>")
map("n", "<LEADER>gh", "<CMD>diffget //2<CR>")
map("n", "<LEADER>gl", "<CMD>diffget //3<CR>")
