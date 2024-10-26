function dynamic_path()
  local filetype = vim.bo.ft
  local cwd = vim.fn.getcwd()
  local root = cwd:match("^[^:]")
  local path = vim.fn.expand("%:.")

  if string.find(filetype, "help") then path = "help\\" .. string.match(path, "\\doc\\(.*)")
  elseif string.find(filetype, "list") then path = string.gsub(path, "^list:///", "")
  elseif string.find(filetype, "qf") then path = "quickfix"
  elseif string.find(filetype, "notify") then path = "notify"
  elseif string.find(filetype, "TelescopePrompt") then path = "telescope"
  elseif string.find(filetype, "harpoon") then path = "harpoon"

  elseif string.find(path, "^fugitive:\\\\\\") then
    if string.find(path, ".git\\\\0\\") then path = "fugitive\\remote"
    elseif string.find(path, ".git\\\\2\\") then path = "fugitive\\new"
    elseif string.find(path, ".git\\\\3\\") then path = "fugitive\\old"
    else path = "fugitive" end
  elseif string.find(path, ".git\\COMMIT_EDITMSG") then
    path = "fugitive\\commit"

  elseif string.find(filetype, "oil") then
    path = string.gsub(path, "^oil:///", "")
    path = string.sub(path, 0, 1) .. ":" .. string.sub(path, 2)
    path = string.gsub(path, "/", "\\")
    if cwd ~= root .. ":\\" then path = string.gsub(path, cwd, cwd:match("^.*\\(.*)$")) end
  elseif string.find(filetype, "netrw") then
    if not string.find(path, ":/") then path = cwd:match("^.*\\(.*)$") .. "\\" .. path end

  else
    if cwd:match("^.*\\(.*)$") == nil or cwd:match("^.*\\(.*)$") == "" then
      if not string.find(path, root .. ":\\") then path = root .. ":\\" .. path end
    else
      path = cwd:match("^.*\\(.*)$") .. "\\" .. path
    end
    if (vim.bo.modified) then path = path .. " ⬤" end
  end

  if string.match(path, "^." .. root .. ":") then path = string.gsub(path, "^.", "") end
  if string.match(path, "^.\\" .. root .. ":\\") then path = string.gsub(path, "^.\\", "") end

  path = string.gsub(path, "\\", "/")
  return path
end

function current_macro()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return "@~"
  else
    return "@" .. recording_register
  end
end

local lualine = require("lualine")
lualine.setup
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
    refresh = {statusline = 1000, tabline = 1000, winbar = 1000}
  },
  sections =
  {
    lualine_a = {"mode"},
    lualine_b = {{"dynamic_path", fmt = dynamic_path}},
    lualine_c = {"diagnostics"},
    lualine_x = {"diff"},
    lualine_y = {{"current_macro", fmt = current_macro}},
    lualine_z = {"progress", "location"}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

vim.api.nvim_create_autocmd("RecordingEnter", {callback = function() lualine.refresh({place = {"statusline"}}) end})
vim.api.nvim_create_autocmd("RecordingLeave", {callback = function()
  local timer = vim.loop.new_timer() timer:start(50, 0, vim.schedule_wrap(function() lualine.refresh({place = {"statusline"}}) end))
end})
