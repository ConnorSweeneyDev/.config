require("oil").setup({
  default_file_explorer = false,
  skip_confirm_for_simple_edits = false,
  view_options = { show_hidden = true, is_hidden_file = function(name, _) return Startswith(name, ".") end },
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
  },
})
Map("n", "<LEADER>pv", "<CMD>Oil<CR>")
Oil_util.open_on_startup()
