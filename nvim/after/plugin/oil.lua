require("oil").setup
{
  default_file_explorer = false,
  skip_confirm_for_simple_edits = false,
  view_options =
  {
    show_hidden = true,
    is_hidden_file = function(name, bufnr) return vim.startswith(name, ".") end,
  },
  keymaps =
  {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = false,
    ["<C-h>"] = false,
    ["<C-t>"] = false,
    ["<C-p>"] = "actions.preview",
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
vim.keymap.set("n", "<LEADER>pv", "<CMD>Oil<CR>")

local function floating_window_exists()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then return true end
  end
  return false
end
if not floating_window_exists() then vim.cmd("Oil") end
