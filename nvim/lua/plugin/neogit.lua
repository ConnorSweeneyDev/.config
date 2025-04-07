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
  mappings = {
    status = {
      ["q"] = false,
      ["<c-r>"] = false,
      ["ZZ"] = function() Neogit_util.close_status_menu("Oil") end,
      ["<c-l>"] = "RefreshBuffer",
    },
    popup = {
      ["Z"] = false,
      ["q"] = "StashPopup",
    },
    commit_editor = {
      ["q"] = false,
      ["<c-c><c-c>"] = false,
      ["<c-c><c-k>"] = false,
      ["ZZ"] = "Submit",
      ["ZQ"] = "Abort",
    },
    rebase_editor = {
      ["q"] = false,
      ["<c-c><c-c>"] = false,
      ["<c-c><c-k>"] = false,
      ["ZZ"] = "Submit",
      ["ZQ"] = "Abort",
    },
  },
})
Map("n", "<LEADER>gs", function() Neogit_util.open_status_menu() end, { desc = "Open Neogit" })
Map("n", "<LEADER>gr", "<CMD>!git restore %<CR>", { desc = "Git restore the current file" })
Map("n", "<LEADER>gR", "<CMD>!git restore .<CR>", { desc = "Git restore the current directory" })
