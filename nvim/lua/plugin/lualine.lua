local vscode = require("lualine.themes.vscode")
vscode.normal.a.fg = "#262626"
vscode.normal.a.bg = "#0a7aca"
vscode.normal.a.gui = "bold"
vscode.visual.b.fg = "#ffaf00"
vscode.visual.b.bg = "#373737"
require("lualine").setup({
  options = {
    theme = vscode,
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
    refresh = { statusline = 10, tabline = 10, winbar = 10 },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "dynamic_path", fmt = Lualine_util.dynamic_path } },
    lualine_c = { "diagnostics" },
    lualine_x = { "diff" },
    lualine_y = { "branch" },
    lualine_z = { "progress", "location" },
  },
})
