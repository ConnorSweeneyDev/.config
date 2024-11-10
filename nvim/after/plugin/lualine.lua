function dynamic_path()
  local filetype = vim.bo.ft
  local cwd = vim.fn.getcwd()
  local root = cwd:match("^[^:]")
  local path = vim.fn.expand("%:.")

  if string.match(filetype, "help") then path = "help\\" .. string.match(path, "\\doc\\(.*)")
  elseif string.match(filetype, "list") then path = string.gsub(path, "^list:///", "")
  elseif string.match(filetype, "qf") then path = "quickfix"
  elseif string.match(filetype, "lazy") then path = "lazy"
  elseif string.match(filetype, "harpoon") then path = "harpoon"
  elseif string.match(filetype, "notify") then path = "notify"
  elseif string.match(filetype, "TelescopePrompt") then path = "telescope"
  elseif string.match(filetype, "fugitive") then
    if string.find(path, ".git\\\\0\\") then path = "fugitive\\remote"
    elseif string.find(path, ".git\\\\2\\") then path = "fugitive\\new"
    elseif string.find(path, ".git\\\\3\\") then path = "fugitive\\old"
    else path = "fugitive" end
  elseif string.match(filetype, "gitcommit") then
    path = "fugitive\\commit"

  elseif string.match(filetype, "oil") then
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
      if not string.find(path, root .. ":\\") then path = cwd:match("^.*\\(.*)$") .. "\\" .. path end
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
    lualine_b = {{"dynamic_path", fmt = dynamic_path}},
    lualine_c = {"diagnostics"},
    lualine_x = {"diff"},
    lualine_y = {{"current_macro", fmt = current_macro}},
    lualine_z = {"progress", "location"}
  }
}
