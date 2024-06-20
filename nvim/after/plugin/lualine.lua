local lualine = require("lualine")

lualine.setup
{
  options =
  {
    icons_enabled = true,
    theme = "vscode",
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = ""},
    disabled_filetypes = { statusline = {}, winbar = {}, },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = { statusline = 1000, tabline = 1000, winbar = 1000, }
  },
  sections =
  {
    lualine_a = {"mode"},
    lualine_b = {{"filename", path = 1}},
    lualine_c = {"diagnostics"},
    lualine_x = {"diff"},
    lualine_y = {{"macro-recording", fmt = show_macro_recording}},
    lualine_z = {"location"}
  },
  inactive_sections =
  {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

vim.api.nvim_create_autocmd("RecordingEnter",
{
  callback = function() lualine.refresh({ place = { "statusline" }, }) end,
})

vim.api.nvim_create_autocmd("RecordingLeave",
{
  callback = function() local timer = vim.loop.new_timer()
    timer:start( 50, 0, vim.schedule_wrap(function() lualine.refresh({ place = { "statusline" }, }) end))
  end,
})
