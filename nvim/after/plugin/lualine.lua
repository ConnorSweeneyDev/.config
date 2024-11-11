require("lualine").setup
{
  options =
  {
    icons_enabled = true,
    theme = "vscode",
    component_separators = {left = "┃", right = "┃"},
    section_separators = {left = "", right = ""},
    disabled_filetypes = {statusline = {}, winbar = {}},
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {statusline = 10, tabline = 10, winbar = 10}
  },
  sections =
  {
    lualine_a = {"mode"},
    lualine_b = {{"dynamic_path", fmt = lualine_util.dynamic_path}},
    lualine_c = {"diagnostics"},
    lualine_x = {"diff"},
    lualine_y = {{"current_register", fmt = lualine_util.current_register}},
    lualine_z = {"progress", "location"}
  }
}
