General_util = {}
General_util.floating_window_exists = function()
  for _, winid in pairs(Api.nvim_tabpage_list_wins(0)) do
    if Api.nvim_win_get_config(winid).zindex then return true end
  end
  return false
end
General_util.make_relative_files = function(long_files)
  local files = {}
  for _, file in ipairs(long_files) do
    local new_file = string.gsub(string.gsub(file, Fn.getcwd() .. "\\", ""), "\\", "/")
    table.insert(files, new_file)
  end
  return files
end
General_util.find_target_directory = function()
  local target_directory = string.gsub(Fn.expand("%"), Fn.getcwd() .. "\\", "")
  target_directory = string.gsub(string.gsub(target_directory, "/", "\\"), "\\.*$", "")
  if string.find(target_directory, "%.") then target_directory = "" end
  return target_directory
end
General_util.get_patterns_from_gitignore = function()
  local gitignore = Fn.glob(".gitignore")
  if gitignore == "" then return {} end
  local lines = Fn.readfile(gitignore)
  local patterns = {}
  for _, line in ipairs(lines) do
    if line ~= "" and line ~= nil and not string.find(line, "^#") then table.insert(patterns, line) end
  end
  return patterns
end
General_util.opened_file = function()
  local args = Fn.execute(":args"):gsub("%s+", ""):gsub("%[", ""):gsub("%]", "")
  if args ~= "." and (args:match("%.%w+$") or args:match("%.%w+%.%w+$")) then return true end
  if args:match("%.git\\COMMIT_EDITMSG$") then return true end
  return false
end

----------------------------------------------------------------------------------------------------

Color_util = {}
Color_util.initialize_colors = function(scheme, highlights)
  Cmd.colorscheme(scheme)
  for _, highlight in ipairs(highlights) do
    Cmd("highlight " .. highlight)
  end
end

----------------------------------------------------------------------------------------------------

Buffer_util = {}
Buffer_util.folders = {}
Buffer_util.file_extensions = {}
Buffer_util.ignore_patterns = {}
Buffer_util.set_parameters = function(folders, file_extensions, ignore_patterns)
  Buffer_util.folders = folders
  Buffer_util.file_extensions = file_extensions
  Buffer_util.ignore_patterns = ignore_patterns
end
Buffer_util.open_buffers = function()
  local original_buffer = Api.nvim_get_current_buf()
  for _, folder in ipairs(Buffer_util.folders) do
    for _, extension in ipairs(Buffer_util.file_extensions) do
      local files = General_util.make_relative_files(Fn.globpath(Fn.getcwd() .. folder, "**/" .. extension, 0, 1))
      for _, file in ipairs(files) do
        local valid_file = true
        for _, ignore_pattern in ipairs(Buffer_util.ignore_patterns) do
          if string.find(ignore_pattern, "^%.") then ignore_pattern = ignore_pattern .. "$" end
          ignore_pattern = string.gsub(ignore_pattern, "%.", "%%.")
          ignore_pattern = string.gsub(ignore_pattern, "^%*", "")
          ignore_pattern = string.gsub(ignore_pattern, "%*$", "")
          if string.find(file, ignore_pattern) then
            valid_file = false
            break
          end
        end
        if valid_file then Cmd("edit " .. file) end
      end
    end
  end
  Api.nvim_set_current_buf(original_buffer)
end
Buffer_util.close_buffers = function()
  local original_buffer = Api.nvim_get_current_buf()
  local buffers = Api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if buffer ~= original_buffer then Api.nvim_buf_delete(buffer, { force = true }) end
  end
end
Buffer_util.manual_open = function()
  Buffer_util.open_buffers()
  Notify("Buffers opened.")
end
Buffer_util.manual_close = function()
  Buffer_util.close_buffers()
  Notify("Buffers closed.")
end
Buffer_util.open_on_startup = function()
  if General_util.floating_window_exists() or General_util.opened_file() then return end
  Buffer_util.open_buffers()
end

----------------------------------------------------------------------------------------------------

Quickfix_util = {}
Quickfix_util.grep_search = function()
  local target_directory = General_util.find_target_directory()
  Api.nvim_input(":silent grep  " .. target_directory .. "<C-Left><Left>")
end
Quickfix_util.grep_word = function()
  local target_directory = General_util.find_target_directory()
  Api.nvim_input('"+yiw:silent grep <C-r><C-w> ' .. target_directory .. "<CR>")
end
Quickfix_util.grep_full_word = function()
  local target_directory = General_util.find_target_directory()
  Api.nvim_input('"+yiw:silent grep <C-r><C-a> ' .. target_directory .. "<CR>")
end
Quickfix_util.grep_selection = function()
  local target_directory = General_util.find_target_directory()
  Api.nvim_input('"+ygv"hy:silent grep <C-r>h ' .. target_directory .. "<CR>")
end

----------------------------------------------------------------------------------------------------

Language_util = {}
Language_util.textwidth = 0
Language_util.set_textwidth = function(textwidth)
  Language_util.textwidth = textwidth
  return textwidth
end
Language_util.format = function(formatters)
  Cmd("w")
  local current_extension = (Fn.expand("%:e") ~= "" and Fn.expand("%:e") ~= nil) and Fn.expand("%:e") or Bo.filetype
  for extensions, command in pairs(formatters) do
    for _, target_extension in ipairs(extensions) do
      if current_extension == target_extension then
        Cmd("!" .. command)
        return
      end
    end
  end
  Notify("Formatting not configured for " .. current_extension .. "!", "error")
end
Language_util.handle_text = function(files)
  local current_extension = Fn.expand("%:e")
  local current_filetype = Bo.filetype
  local match = false
  for _, file in ipairs(files) do
    if current_extension == file or current_filetype == file then
      Opt.formatoptions:append("t")
      match = true
      break
    end
  end
  if not match then Opt.formatoptions:remove("t") end
end
Language_util.handle_gitcommit = function(textwidth)
  if Bo.filetype == "gitcommit" then
    Opt.textwidth = textwidth
    Opt.colorcolumn = tostring(textwidth)
  else
    Opt.textwidth = Language_util.textwidth
    Opt.colorcolumn = tostring(Language_util.textwidth)
  end
end

----------------------------------------------------------------------------------------------------

Lua_util = {}
Lua_util.source = function()
  local extension = Fn.expand("%:e")
  if extension == "lua" then
    Cmd("source %")
  else
    Notify("Not a lua file!", "error")
  end
end

----------------------------------------------------------------------------------------------------

C_util = {}
C_util.get_files_in_compilation_unit = function()
  local target_directory = General_util.find_target_directory()
  if target_directory ~= "" then target_directory = "\\" .. target_directory end
  local directory = Fn.getcwd() .. target_directory
  local name = Fn.expand("%:t:r")
  local long_files = Fn.globpath(directory, "**/" .. name .. ".*", 0, 1)
  local files = General_util.make_relative_files(long_files)
  return files
end
C_util.assign_cxx_file_types = function(files)
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
C_util.assign_cc_file_types = function(files)
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
C_util.switch_file_in_compilation_unit = function(target_file)
  local current_extension = Fn.expand("%:e")
  local files = C_util.get_files_in_compilation_unit()
  if
    string.match(current_extension, "cpp")
    or string.match(current_extension, "hpp")
    or string.match(current_extension, "inl")
  then
    local target_extension = ""
    if target_file == "source" then
      target_extension = "cpp"
    elseif target_file == "header" then
      target_extension = "hpp"
    elseif target_file == "inline" then
      target_extension = "inl"
    else
      Notify("Unexpected target file!", "error")
      return
    end
    if string.match(current_extension, target_extension) then
      Notify("Already in " .. target_extension .. " file!", "error")
      return
    end
    if #files == 0 then
      Notify("Problem reading filename!", "error")
    elseif #files == 1 then
      Notify("There is only one file in this compilation unit!", "error")
    elseif #files == 2 or #files == 3 then
      local source, header, inline = C_util.assign_cxx_file_types(files)
      if target_extension == "cpp" then
        if source ~= "" then
          Cmd("edit " .. source)
        else
          Notify("No cpp file found!", "error")
        end
      elseif target_extension == "hpp" then
        if header ~= "" then
          Cmd("edit " .. header)
        else
          Notify("No hpp file found!", "error")
        end
      elseif target_extension == "inl" then
        if inline ~= "" then
          Cmd("edit " .. inline)
        else
          Notify("No inl file found!", "error")
        end
      else
        Notify("Unexpected target file extension!", "error")
      end
    else
      Notify("Unexpectedly high amount of corresponding files found!", "error")
    end
  elseif string.match(current_extension, "c") or string.match(current_extension, "h") then
    local target_extension = ""
    if target_file == "source" then
      target_extension = "c"
    elseif target_file == "header" then
      target_extension = "h"
    else
      Notify("Unexpected target file!", "error")
      return
    end
    if string.match(current_extension, target_extension) then
      Notify("Already in " .. target_extension .. " file!", "error")
      return
    end
    if #files == 0 then
      Notify("Problem reading filename!", "error")
    elseif #files == 1 then
      Notify("There is only one file in this compilation unit!", "error")
    elseif #files == 2 then
      local source, header = C_util.assign_cc_file_types(files)
      if target_extension == "c" then
        if source ~= "" then
          Cmd("edit " .. source)
        else
          Notify("No c file found!", "error")
        end
      elseif target_extension == "h" then
        if header ~= "" then
          Cmd("edit " .. header)
        else
          Notify("No h file found!", "error")
        end
      else
        Notify("Unexpected target file extension!", "error")
      end
    else
      Notify("Unexpectedly high amount of corresponding files found!", "error")
    end
  else
    Notify("Not a c, h, cpp, hpp or inl file!", "error")
  end
end

----------------------------------------------------------------------------------------------------

Lazy_util = {}
Lazy_util.bootstrap = function()
  local lazypath = Fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (Uv or Loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = Fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if V.shell_error ~= 0 then
      Api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      Fn.getchar()
      os.exit(1)
    end
  end
  Opt.rtp:prepend(lazypath)
end

----------------------------------------------------------------------------------------------------

Lualine_util = {}
Lualine_util.dynamic_path = function()
  local filetype = Bo.filetype
  local path = Fn.expand("%:.")
  local cwd = Fn.getcwd()
  local root = cwd:match("^[^:]")
  local modified_symbol = " ⬤"
  if path == "" and filetype == "" then
    return "none"
  elseif string.match(filetype, "help") then
    path = "help\\" .. string.match(path, "\\doc\\(.*)")
  elseif string.match(filetype, "list") then
    path = string.gsub(path, "^list:///", "")
  elseif string.match(filetype, "qf") then
    path = "quickfix"
  elseif string.match(filetype, "lazy") then
    path = "lazy"
  elseif string.match(filetype, "harpoon") then
    path = "harpoon"
  elseif string.match(filetype, "notify") then
    path = "notify"
  elseif string.match(filetype, "noice") then
    path = "noice"
  elseif string.match(filetype, "TelescopePrompt") then
    path = "telescope"
  elseif string.match(filetype, "gitcommit") then
    path = "neogit\\commit"
  elseif string.find(filetype, "Neogit") then
    path = "neogit\\" .. string.lower(string.gsub(filetype, "Neogit", ""))
  elseif string.find(filetype, "Diffview") then
    path = "diffview\\" .. string.lower(string.gsub(filetype, "Diffview", ""))
  elseif string.find(path, "diffview:///") then
    path = "diffview\\panel"
  elseif string.find(path, ".git/:0:/") then
    path = "diffview\\remote"
  elseif string.find(path, ".git/:1:/") then
    path = "diffview\\base"
  elseif string.find(path, ".git/:2:/") then
    path = "diffview\\ours"
  elseif string.find(path, ".git/:3:/") then
    path = "diffview\\theirs"
  elseif string.match(filetype, "netrw") then
    if not string.find(path, ":/") then path = cwd:match("^.*\\(.*)$") .. "\\" .. path end
  elseif string.match(filetype, "oil_preview") then
    path = "confirm"
  elseif string.match(filetype, "oil") then
    local trash = false
    if string.find(path, "^oil.-trash:///") then
      path = string.gsub(path, "^oil.-trash:///", "")
      trash = true
    else
      path = string.gsub(path, "^oil:///", "")
    end
    path = string.sub(path, 0, 1) .. ":" .. string.sub(path, 2)
    path = string.gsub(path, "/", "\\")
    if cwd ~= root .. ":\\" then path = string.gsub(path, cwd, cwd:match("^.*\\(.*)$")) end
    if trash then path = "trash -> " .. path end
    if Bo.modified then path = path .. modified_symbol end
  else
    if cwd:match("^.*\\(.*)$") == nil or cwd:match("^.*\\(.*)$") == "" then
      if not string.find(path, root .. ":\\") then path = root .. ":\\" .. path end
    else
      if not string.find(path, root .. ":\\") then path = cwd:match("^.*\\(.*)$") .. "\\" .. path end
    end
    if Bo.modified then path = path .. modified_symbol end
  end
  if string.match(path, "^." .. root .. ":") then path = string.gsub(path, "^.", "") end
  if string.match(path, "^.\\" .. root .. ":\\") then path = string.gsub(path, "^.\\", "") end
  path = string.gsub(path, "\\", "/")
  return path
end
Lualine_util.current_register = function()
  local recording_register = Fn.reg_recording()
  if recording_register ~= "" then return "@" .. recording_register end
  return "@~"
end

----------------------------------------------------------------------------------------------------

Oil_util = {}
Oil_util.open_on_startup = function()
  if General_util.floating_window_exists() or General_util.opened_file() then return end
  Cmd("Oil .")
  for _, buffer in ipairs(Api.nvim_list_bufs()) do
    if Api.nvim_get_option_value("ft", { buf = buffer }) == "" then
      Api.nvim_buf_delete(buffer, { force = true })
      break
    end
  end
end

----------------------------------------------------------------------------------------------------

Mason_util = {}
Mason_util.install_and_enable = function(mason_registry, servers)
  for name, opts in pairs(servers) do
    if name ~= "*" and not mason_registry.is_installed(name) then Cmd("MasonInstall " .. name) end
    Lsp.config(name, opts)
    if name ~= "*" then Lsp.enable(name) end
  end
end
Mason_util.disable_capabilities = function(capabilities)
  return function(client, _)
    for _, capability in ipairs(capabilities) do
      client.server_capabilities[capability] = nil
    end
  end
end

----------------------------------------------------------------------------------------------------

Neogit_util = {}
Neogit_util.last_buffer = nil
Neogit_util.open_status_menu = function()
  Neogit_util.last_buffer = Bo.filetype
  local cwd = Fn.getcwd()
  Cmd("Neogit")
  Api.nvim_set_current_dir(cwd)
end
Neogit_util.close_status_menu = function(file_explorer)
  if Neogit_util.last_buffer == "netrw" or Neogit_util.last_buffer == "oil" or Neogit_util.last_buffer == nil then
    Cmd(file_explorer .. " .")
  else
    Api.nvim_input("<C-o>")
  end
end

----------------------------------------------------------------------------------------------------

Diffview_util = {}
Diffview_util.fullscreen = function()
  local window = { type = "float" }
  local editor_width = O.columns
  local editor_height = O.lines
  window.width = editor_width
  window.height = editor_height
  window.col = math.floor(editor_width * 0.5 - window.width * 0.5)
  window.row = math.floor(editor_height * 0.5 - window.height * 0.5)
  return window
end

----------------------------------------------------------------------------------------------------

Supermaven_util = {}
Supermaven_util.disable_for_large_files = function(supermaven_api, max_size)
  local size = Fn.getfsize(Fn.expand("%"))
  if size > max_size and supermaven_api.is_running() then
    Cmd("SupermavenStop")
  elseif size <= max_size and not supermaven_api.is_running() then
    Cmd("SupermavenStart")
  end
end
