require("neogit").setup({
  disable_hint = true,
  disable_context_highlighting = true,
  disable_signs = true,
  graph_style = "unicode",
  highlight = { italic = false, bold = true, underline = false },
  kind = "replace",
  disable_line_numbers = false,
  disable_relative_line_numbers = false,
  commit_view = { kind = "vsplit", verify_commit = false },
  mappings = { status = { ["<c-l>"] = "RefreshBuffer", ["q"] = function() Neogit_util.close_status_menu("Oil") end } },
})
Map("n", "<LEADER>gs", function() Neogit_util.open_status_menu() end)
Map("n", "<LEADER>gr", "<CMD>!git restore %<CR>")
Map("n", "<LEADER>gR", "<CMD>!git restore .<CR>")
