require("oil").setup{
  default_file_explorer = false,
  skip_confirm_for_simple_edits = false,
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, bufnr) return vim.startswith(name, ".") end,
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = false,
    ["<C-h>"] = false,
    ["<C-t>"] = false,
    ["<C-p>"] = false,
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = false,
    ["`"] = false,
    ["~"] = false,
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  }
}
map("n", "<LEADER>pv", "<CMD>Oil<CR>")
oil_util.open_on_startup()
api.nvim_create_autocmd({"BufEnter"}, {callback = function() oil_util.replace_netrw() end})
