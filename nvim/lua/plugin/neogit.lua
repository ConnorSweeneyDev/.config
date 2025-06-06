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
vim.keymap.set("n", "<LEADER>gs", function() Neogit_util.open_status_menu() end, { desc = "Open Neogit" })
vim.keymap.set("n", "<LEADER>gr", "<CMD>!git restore %<CR><CR>", { desc = "Git restore the current file" })
vim.keymap.set("n", "<LEADER>gR", "<CMD>!git restore .<CR><CR>", { desc = "Git restore the current directory" })
vim.keymap.set(
  "n",
  "<C-g>",
  function() Neogit_util.copy_current_file_url(false) end,
  { desc = "Copy current file url" }
)
vim.keymap.set(
  "n",
  "g<C-g>",
  function() Neogit_util.copy_current_file_url(true) end,
  { desc = "Copy current file url with line number anchor" }
)
