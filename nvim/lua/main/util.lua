map = vim.keymap.set
opt = vim.opt
api = vim.api
g = vim.g

--------------------------------------------------------------------------------

lazy_util = {}
lazy_util.bootstrap = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  opt.rtp:prepend(lazypath)
end

--------------------------------------------------------------------------------

general_util = {}
general_util.floating_window_exists = function()
  for _, winid in pairs(api.nvim_tabpage_list_wins(0)) do
    if api.nvim_win_get_config(winid).zindex then return true end
  end
  return false
end

--------------------------------------------------------------------------------

cc_util = {}
cc_util.assign_files = function(long_files, cwd)
  local files = {}
  for _, file in ipairs(long_files) do
    local new_file = string.gsub(file, cwd .. "\\", "")
    new_file = string.gsub(new_file, "\\", "/")
    table.insert(files, new_file)
  end
  return files
end
cc_util.assign_file_types = function(files)
  local source = ""
  local header = ""
  for _, file in ipairs(files) do
    if string.match(file, "%.c$") then
      source = file
    elseif string.match(file, "%.h$") then
      header = file
    end
  end
  return source, header
end
cc_util.switch_file_in_unit = function(dir)
  local extension = vim.fn.expand("%:e")
  if not string.match(extension, "c") and not string.match(extension, "h") then
    vim.notify("Not a C source or header file!", "error")
    return
  end
  local cwd = vim.fn.getcwd()
  local name = vim.fn.expand("%:t:r")
  local long_files = vim.fn.globpath(dir, "**/" .. name .. ".*", 0, 1)
  local files = cc_util.assign_files(long_files, cwd)
  if #files == 0 then
    vim.notify("Problem reading filename!", "error")
  elseif #files == 1 then
    vim.notify("There is only one file in this compilation unit!", "error")
  elseif #files == 2 then
    local source, header = cc_util.assign_file_types(files)
    local other_file = ""
    if string.match(extension, "c") then
      other_file = header
    elseif string.match(extension, "h") then
      other_file = source
    else
      vim.notify("Unexpected file extension!", "error")
      return
    end
    vim.cmd("edit " .. other_file)
  else
    vim.notify("Unexpectedly high amount of corresponding files found!", "error")
  end
end

--------------------------------------------------------------------------------

cxx_util = {}
cxx_util.assign_files = function(long_files, cwd)
  local files = {}
  for _, file in ipairs(long_files) do
    local new_file = string.gsub(file, cwd .. "\\", "")
    new_file = string.gsub(new_file, "\\", "/")
    table.insert(files, new_file)
  end
  return files
end
cxx_util.assign_file_types = function(files)
  local source = ""
  local header = ""
  local inline = ""
  for _, file in ipairs(files) do
    if string.match(file, "%.cpp$") then
      source = file
    elseif string.match(file, "%.hpp$") then
      header = file
    elseif string.match(file, "%.inl$") then
      inline = file
    end
  end
  return source, header, inline
end
cxx_util.find_one_from_two = function(file1, file2)
  if file1 ~= "" then
    return file1
  elseif file2 ~= "" then
    return file2
  end
end
cxx_util.switch_file_in_unit = function(dir)
  local extension = vim.fn.expand("%:e")
  if not string.match(extension, "cpp") and not string.match(extension, "hpp") and not string.match(extension, "inl") then
    vim.notify("Not a C++ source, header or inline file!", "error")
    return
  end
  local cwd = vim.fn.getcwd()
  local name = vim.fn.expand("%:t:r")
  local long_files = vim.fn.globpath(dir, "**/" .. name .. ".*", 0, 1)
  local files = cxx_util.assign_files(long_files, cwd)
  if #files == 0 then
    vim.notify("Problem reading filename!", "error")
  elseif #files == 1 then
    vim.notify("There is only one file in this compilation unit!", "error")
  elseif #files == 2 then
    local source, header, inline = cxx_util.assign_file_types(files)
    local other_file = ""
    if string.match(extension, "cpp") then
      other_file = cxx_util.find_one_from_two(header, inline)
    elseif string.match(extension, "hpp") then
      other_file = cxx_util.find_one_from_two(source, inline)
    elseif string.match(extension, "inl") then
      other_file = cxx_util.find_one_from_two(source, header)
    else
      vim.notify("Unexpected file extension!", "error")
      return
    end
    vim.cmd("edit " .. other_file)
  elseif #files == 3 then
    local source, header, inline = cxx_util.assign_file_types(files)
    local selection = {}
    if string.match(extension, "cpp") then
      selection = {header, inline}
    elseif string.match(extension, "hpp") then
      selection = {source, inline}
    elseif string.match(extension, "inl") then
      selection = {source, header}
    else
      vim.notify("Unexpected file extension!", "error")
      return
    end
    local extension_selection = {}
    for _, file in ipairs(selection) do
      table.insert(extension_selection, string.match(file, "%.([^.]+)$"))
    end
    local choice = require("lacasitos").choose_option(extension_selection)
    if choice then
      if choice == string.match(selection[1], "%.([^.]+)$") then vim.cmd("edit " .. selection[1])
      else vim.cmd("edit " .. selection[2]) end
    end
  else
    vim.notify("Unexpectedly high amount of corresponding files found!", "error")
  end
end

--------------------------------------------------------------------------------

buffer_util = {}
buffer_util.open_buffers = function(folders, file_extensions, ignore_files)
  local folders = {"/program", "/src", "/lua", "/after"}
  local file_extensions = {"*.cpp", "*.hpp", "*.inl", "*.glsl", "*.c", "*.h", "*.py", "*.lua", "*.java", "*.cs"}
  local ignore_files = {"resource.cpp", "resource.hpp"}
  local original_buffer = api.nvim_get_current_buf()
  for _, folder in ipairs(folders) do
    for _, extension in ipairs(file_extensions) do
      local files = vim.fn.globpath(vim.fn.getcwd() .. folder, "**/" .. extension, 0, 1)
      for _, file in ipairs(files) do
        if not vim.tbl_contains(ignore_files, vim.fn.fnamemodify(file, ":t")) then
          vim.cmd("edit " .. file)
        end
      end
    end
  end
  api.nvim_set_current_buf(original_buffer)
end
buffer_util.close_buffers = function()
  local original_buffer = api.nvim_get_current_buf()
  local buffers = api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if buffer ~= original_buffer then
      api.nvim_buf_delete(buffer, {force = true})
    end
  end
end
buffer_util.manual_open = function(folders, file_extensions, ignore_files, use_coc)
  buffer_util.open_buffers(folders, file_extensions, ignore_files)
  if use_coc then vim.cmd("silent CocRestart") end
  vim.notify("Buffers opened.")
end
buffer_util.manual_close = function(use_coc)
  buffer_util.close_buffers()
  if use_coc then vim.cmd("silent CocRestart") end
  vim.notify("Buffers closed.")
end
buffer_util.open_on_startup = function(folders, file_extensions, ignore_files)
  if general_util.floating_window_exists() then return end
  local original_buffer = api.nvim_get_current_buf()
  buffer_util.open_buffers(folders, file_extensions, ignore_files)
  vim.cmd("bd 1")
  api.nvim_set_current_buf(original_buffer)
end

--------------------------------------------------------------------------------

color_util = {}
color_util.initialize_colors = function(scheme, highlights)
  vim.cmd.colorscheme(scheme)
  api.nvim_set_hl(0, "Normal", {bg = "none"})
  api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
  for _, highlight in ipairs(highlights) do
    vim.cmd("highlight " .. highlight)
  end
end
color_util.line_number_handler = function(line_colors)
  local separator = " ▎ "
  opt.statuscolumn = "%s%=" ..
  "%#LineNr4#%{(v:relnum >= 4)?v:relnum.\"" .. separator .. "\":\"\"}" ..
  "%#LineNr3#%{(v:relnum == 3)?v:relnum.\"" .. separator .. "\":\"\"}" ..
  "%#LineNr2#%{(v:relnum == 2)?v:relnum.\"" .. separator .. "\":\"\"}" ..
  "%#LineNr1#%{(v:relnum == 1)?v:relnum.\"" .. separator .. "\":\"\"}" ..
  "%#LineNr0#%{(v:relnum == 0)?v:lnum.\" " .. separator .. "\":\"\"}"
  vim.cmd("highlight LineNr0 guifg=" .. line_colors[1])
  vim.cmd("highlight LineNr1 guifg=" .. line_colors[2])
  vim.cmd("highlight LineNr2 guifg=" .. line_colors[3])
  vim.cmd("highlight LineNr3 guifg=" .. line_colors[4])
  vim.cmd("highlight LineNr4 guifg=" .. line_colors[5])
end

--------------------------------------------------------------------------------

lualine_util = {}
lualine_util.dynamic_path = function()
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
  elseif string.match(filetype, "fugitive") then path = "fugitive"
  elseif string.match(filetype, "gitcommit") then path = "commit"
  elseif string.find(path, ".git\\\\0\\") then path = "remote"
  elseif string.find(path, ".git\\\\2\\") then path = "new"
  elseif string.find(path, ".git\\\\3\\") then path = "old"
  elseif string.find(path, "__coc_refactor__") then path = "refactor"
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
lualine_util.current_register = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return "@~"
  else
    return "@" .. recording_register
  end
end

--------------------------------------------------------------------------------

oil_util = {}
oil_util.open_on_startup = function() if not general_util.floating_window_exists() then vim.cmd("Oil") end end

--------------------------------------------------------------------------------

coc_util = {}
coc_util.show_docs = function()
  local cw = vim.fn.expand("<cword>")
  if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
    api.nvim_command("h " .. cw)
  elseif api.nvim_eval("coc#rpc#ready()") then
    vim.fn.CocActionAsync("doHover")
  else
    api.nvim_command("!" .. opt.keywordprg .. " " .. cw)
  end
end
coc_util.refactor_handler = function()
  language = vim.fn.expand("%:e")
  if language ~= "" and language ~= nil then
    if language == "h" then language = "c" end
    if language == "hpp" or language == "inl" then language = "cpp" end
    vim.treesitter.language.register(language, "crf")
  end
  if string.find(vim.fn.expand("%"), "__coc_refactor__") then vim.cmd("set filetype=crf") end
end