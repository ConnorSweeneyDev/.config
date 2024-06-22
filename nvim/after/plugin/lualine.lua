local lualine = require("lualine")

lualine.setup
{
  options =
  {
    icons_enabled = true,
    theme = "vscode",
    component_separators = { left = "|", right = "|"},
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
    lualine_b = {{"relative_path", fmt = get_relative_path}},
    lualine_c = {"diagnostics"},
    lualine_x = {"diff"},
    lualine_y = {{"macro-recording", fmt = show_macro_recording}},
    lualine_z = {"progress", "location"}
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

function get_relative_path()
  local path = vim.fn.expand("%:.")
  if string.match(path, "^oil:///") then
    path = string.gsub(path, "^oil:///", "")
    path = string.sub(path, 0, 1) .. ":" .. string.sub(path, 2)
    path = string.gsub(path, "/", "\\")
    path = string.gsub(path, vim.fn.getcwd(), "")
    path = "." .. path
  else
    path = ".\\" .. path
  end

  if string.match(path, "^.C:") then
    path = string.gsub(path, "^.", "")
  end
  return path
end

function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return "Not Recording"
  else
    return "Recording @" .. recording_register
  end
end

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
