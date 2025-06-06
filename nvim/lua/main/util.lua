General_util = {}
General_util.opened_file = function()
  local args = vim.fn.execute(":args"):gsub("%s+", ""):gsub("%[", ""):gsub("%]", "")
  if args ~= "." and (args:match("%.%w+$") or args:match("%.%w+%.%w+$")) then return true end
  if args:match("%.git\\") then return true end
  return false
end
General_util.floating_window_exists = function()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then return true end
  end
  return false
end
General_util.make_relative_files = function(long_files)
  local files = {}
  for _, file in ipairs(long_files) do
    local new_file = string.gsub(string.gsub(file, vim.fn.getcwd() .. "\\", ""), "\\", "/")
    table.insert(files, new_file)
  end
  return files
end
General_util.find_target_directory = function()
  local target_directory = string.gsub(vim.fn.expand("%"), vim.fn.getcwd() .. "\\", "")
  target_directory = string.gsub(string.gsub(target_directory, "/", "\\"), "\\.*$", "")
  if string.find(target_directory, "%.") then target_directory = "" end
  return target_directory
end
General_util.cwd_contains = function(patterns)
  local cwd = vim.fn.getcwd()
  for _, pattern in ipairs(patterns) do
    local full_pattern = cwd .. "\\" .. pattern
    local result = vim.fn.glob(full_pattern, false, true)
    if #result > 0 then return true end
  end
  return false
end
General_util.get_patterns_from_gitignore = function()
  local gitignore = vim.fn.glob(".gitignore")
  if gitignore == "" then return {} end
  local lines = vim.fn.readfile(gitignore)
  local patterns = {}
  for _, line in ipairs(lines) do
    if line ~= "" and line ~= nil and not string.find(line, "^#") then table.insert(patterns, line) end
  end
  return patterns
end

----------------------------------------------------------------------------------------------------

Color_util = {}
Color_util.initialize_colors = function(scheme, highlights)
  vim.cmd.colorscheme(scheme)
  for _, highlight in ipairs(highlights) do
    vim.cmd("highlight " .. highlight)
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
  local original_buffer = vim.api.nvim_get_current_buf()
  for _, folder in ipairs(Buffer_util.folders) do
    for _, extension in ipairs(Buffer_util.file_extensions) do
      local files =
        General_util.make_relative_files(vim.fn.globpath(vim.fn.getcwd() .. folder, "**/" .. extension, 0, 1))
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
        if valid_file then vim.cmd("edit " .. file) end
      end
    end
  end
  vim.api.nvim_set_current_buf(original_buffer)
end
Buffer_util.close_buffers = function()
  local original_buffer = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if buffer ~= original_buffer then vim.api.nvim_buf_delete(buffer, { force = true }) end
  end
end
Buffer_util.manual_open = function()
  Buffer_util.open_buffers()
  vim.notify("Buffers opened.")
end
Buffer_util.manual_close = function()
  Buffer_util.close_buffers()
  vim.notify("Buffers closed.")
end
Buffer_util.open_on_startup = function()
  if General_util.floating_window_exists() or General_util.opened_file() then return end
  Buffer_util.open_buffers()
end

----------------------------------------------------------------------------------------------------

Quickfix_util = {}
Quickfix_util.rename = function()
  vim.api.nvim_input(
    "<CMD>cdo s/"
      .. vim.fn.input("Original: ")
      .. "/"
      .. vim.fn.input("Substitute: ")
      .. "/"
      .. vim.fn.input("Options: ")
      .. "<CR><CR>"
  )
end
Quickfix_util.grep_search = function(target_directory)
  vim.api.nvim_input(
    "mZ:silent grep "
      .. vim.fn.input("Search Term: ")
      .. " "
      .. vim.fn.input("Target Directory: ", target_directory)
      .. "<CR>`Z"
  )
end
Quickfix_util.grep_word = function(target_directory)
  vim.api.nvim_input(
    'mZ"+yiw:silent grep <C-r><C-w> ' .. vim.fn.input("Target Directory: ", target_directory) .. "<CR>`Z"
  )
end
Quickfix_util.grep_full_word = function(target_directory)
  vim.api.nvim_input(
    'mZ"+yiw:silent grep <C-r><C-a> ' .. vim.fn.input("Target Directory: ", target_directory) .. "<CR>`Z"
  )
end
Quickfix_util.grep_selection = function(target_directory)
  vim.api.nvim_input(
    'mZ"+ygv"hy:silent grep <C-r>h ' .. vim.fn.input("Target Directory: ", target_directory) .. "<CR>`Z"
  )
end

----------------------------------------------------------------------------------------------------

Language_util = {}
Language_util.textwidth = 0
Language_util.set_textwidth = function(textwidth)
  Language_util.textwidth = textwidth
  return textwidth
end
Language_util.formatters = {}
Language_util.format = function(files)
  local current_filetype = vim.bo.filetype
    or (vim.fn.expand("%:e") ~= "" and vim.fn.expand("%:e") ~= nil) and vim.fn.expand("%:e")
  for _, opts in ipairs(Language_util.formatters) do
    for _, target_filetype in ipairs(opts.filetypes) do
      if current_filetype == target_filetype then
        local command = ""
        for _, command_part in ipairs(opts.cmd) do
          if command_part == "[|]" then command_part = files end
          command = command .. command_part .. (next(opts.cmd, _) and " " or "")
        end
        if files == "%" then
          vim.cmd("w")
        else
          vim.cmd("wa")
        end
        vim.cmd("!" .. command)
        vim.api.nvim_input("<CR>")
        return
      end
    end
  end
  vim.notify("Formatting not configured for " .. current_filetype .. "!", "error")
end
Language_util.ides = {}
Language_util.open_ide = function()
  local current_filetype = vim.bo.filetype
    or (vim.fn.expand("%:e") ~= "" and vim.fn.expand("%:e") ~= nil) and vim.fn.expand("%:e")
  for _, opts in ipairs(Language_util.ides) do
    for _, target_filetype in ipairs(opts.filetypes) do
      if current_filetype == target_filetype then
        local command = ""
        for _, command_part in ipairs(opts.cmd) do
          if command_part == "[|]" then
            if opts.targets == { "." } then
              command_part = "."
            else
              for _, target in ipairs(opts.targets) do
                command_part = vim.fn.glob(target)
                if command_part ~= "" then break end
              end
              if command_part == "" then
                vim.notify("No target file found!", "error")
                return
              end
            end
          end
          command = command .. command_part .. (next(opts.cmd, _) and " " or "")
        end
        vim.cmd("!" .. command)
        vim.api.nvim_input("<CR>")
        return
      end
    end
  end
  vim.notify("IDE not configured for " .. current_filetype .. "!", "error")
end
Language_util.copy_display_text = function(use_filename)
  vim.cmd('normal! "zy')
  local text = vim.fn.getreg("z")
  local relative_path = ""
  local output = vim.fn.system('git ls-files --full-name "' .. vim.fn.expand("%:p") .. '"')
  if output:find("fatal:") then
    relative_path = vim.fn.expand("%:.")
  else
    relative_path = output:gsub("\n", "")
  end
  local result = ""
  if use_filename then result = result .. "[" .. relative_path .. "]\n" end
  result = result .. "```" .. vim.bo.filetype .. "\n" .. text .. (text:sub(-1) == "\n" and "```" or "\n```")
  vim.fn.setreg("+", result)
end
Language_util.handle_text = function(files)
  local current_extension = vim.fn.expand("%:e")
  local current_filetype = vim.bo.filetype
  local match = false
  for _, file in ipairs(files) do
    if current_extension == file or current_filetype == file then
      vim.opt.formatoptions:append("t")
      match = true
      break
    end
  end
  if not match then vim.opt.formatoptions:remove("t") end
end
Language_util.handle_gitcommit = function(textwidth)
  if vim.bo.filetype == "gitcommit" then
    vim.opt.textwidth = textwidth
    vim.opt.colorcolumn = tostring(textwidth)
  else
    vim.opt.textwidth = Language_util.textwidth
    vim.opt.colorcolumn = tostring(Language_util.textwidth)
  end
end

----------------------------------------------------------------------------------------------------

Lua_util = {}
Lua_util.source = function()
  local extension = vim.fn.expand("%:e")
  if extension == "lua" then
    vim.cmd("source %")
  else
    vim.notify("Not a lua file!", "error")
  end
end

----------------------------------------------------------------------------------------------------

C_util = {}
C_util.get_files_in_compilation_unit = function()
  local target_directory = General_util.find_target_directory()
  if target_directory ~= "" then target_directory = "\\" .. target_directory end
  local directory = vim.fn.getcwd() .. target_directory
  local name = vim.fn.expand("%:t:r")
  local long_files = vim.fn.globpath(directory, "**/" .. name .. ".*", 0, 1)
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
  local current_extension = vim.fn.expand("%:e")
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
      vim.notify("Unexpected target file!", "error")
      return
    end
    if string.match(current_extension, target_extension) then
      vim.notify("Already in " .. target_extension .. " file!", "error")
      return
    end
    if #files == 0 then
      vim.notify("Problem reading filename!", "error")
    elseif #files == 1 then
      vim.notify("There is only one file in this compilation unit!", "error")
    elseif #files == 2 or #files == 3 then
      local source, header, inline = C_util.assign_cxx_file_types(files)
      if target_extension == "cpp" then
        if source ~= "" then
          vim.cmd("edit " .. source)
        else
          vim.notify("No cpp file found!", "error")
        end
      elseif target_extension == "hpp" then
        if header ~= "" then
          vim.cmd("edit " .. header)
        else
          vim.notify("No hpp file found!", "error")
        end
      elseif target_extension == "inl" then
        if inline ~= "" then
          vim.cmd("edit " .. inline)
        else
          vim.notify("No inl file found!", "error")
        end
      else
        vim.notify("Unexpected target file extension!", "error")
      end
    else
      vim.notify("Unexpectedly high amount of corresponding files found!", "error")
    end
  elseif string.match(current_extension, "c") or string.match(current_extension, "h") then
    local target_extension = ""
    if target_file == "source" then
      target_extension = "c"
    elseif target_file == "header" then
      target_extension = "h"
    else
      vim.notify("Unexpected target file!", "error")
      return
    end
    if string.match(current_extension, target_extension) then
      vim.notify("Already in " .. target_extension .. " file!", "error")
      return
    end
    if #files == 0 then
      vim.notify("Problem reading filename!", "error")
    elseif #files == 1 then
      vim.notify("There is only one file in this compilation unit!", "error")
    elseif #files == 2 then
      local source, header = C_util.assign_cc_file_types(files)
      if target_extension == "c" then
        if source ~= "" then
          vim.cmd("edit " .. source)
        else
          vim.notify("No c file found!", "error")
        end
      elseif target_extension == "h" then
        if header ~= "" then
          vim.cmd("edit " .. header)
        else
          vim.notify("No h file found!", "error")
        end
      else
        vim.notify("Unexpected target file extension!", "error")
      end
    else
      vim.notify("Unexpectedly high amount of corresponding files found!", "error")
    end
  else
    vim.notify("Not a c, h, cpp, hpp or inl file!", "error")
  end
end

----------------------------------------------------------------------------------------------------

Lazy_util = {}
Lazy_util.bootstrap = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
end

----------------------------------------------------------------------------------------------------

Lualine_util = {}
Lualine_util.dynamic_path = function()
  local filetype = vim.bo.filetype
  local path = vim.fn.expand("%:.")
  local cwd = vim.fn.getcwd()
  local root = cwd:match("^[^:]")
  local modified_symbol = " ⬤"
  if path == "" and filetype == "" then
    return "none"
  elseif string.match(filetype, "help") then
    path = "help\\" .. string.match(path, "\\doc\\(.*)")
  elseif string.match(filetype, "checkhealth") then
    path = "checkhealth"
  elseif string.match(filetype, "list") then
    path = string.gsub(path, "^list:///", "")
  elseif string.match(filetype, "qf") then
    path = "quickfix"
  elseif string.match(filetype, "trouble") then
    path = "trouble"
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
  elseif string.find(path, ".git/:0:/") or string.find(path, ".git//:0:") then
    path = "diffview\\remote"
  elseif string.find(path, ".git/:1:/") or string.find(path, ".git//:1:") then
    path = "diffview\\base"
  elseif string.find(path, ".git/:2:/") or string.find(path, ".git//:2:") then
    path = "diffview\\ours"
  elseif string.find(path, ".git/:3:/") or string.find(path, ".git//:3:") then
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
    if vim.bo.modified then path = path .. modified_symbol end
  else
    if cwd:match("^.*\\(.*)$") == nil or cwd:match("^.*\\(.*)$") == "" then
      if not string.find(path, root .. ":\\") then path = root .. ":\\" .. path end
    else
      if not string.find(path, root .. ":\\") then path = cwd:match("^.*\\(.*)$") .. "\\" .. path end
    end
    if vim.bo.modified then path = path .. modified_symbol end
  end
  if string.match(path, "^." .. root .. ":") then path = string.gsub(path, "^.", "") end
  if string.match(path, "^.\\" .. root .. ":\\") then path = string.gsub(path, "^.\\", "") end
  path = string.gsub(path, "\\", "/")
  return path
end

----------------------------------------------------------------------------------------------------

Oil_util = {}
Oil_util.open_on_startup = function()
  if General_util.floating_window_exists() or General_util.opened_file() then return end
  vim.cmd("Oil .")
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_get_option_value("ft", { buf = buffer }) == "" then
      vim.api.nvim_buf_delete(buffer, { force = true })
      break
    end
  end
end

----------------------------------------------------------------------------------------------------

Mason_util = {}
Mason_util.setup_languages = function(mason_registry, configs)
  mason_registry.refresh()
  for _, config in pairs(configs) do
    if config.lsp ~= nil and config.lsp ~= {} then
      if config.lsp.name ~= "*" and not mason_registry.is_installed(config.lsp.name) then
        vim.cmd("MasonInstall " .. config.lsp.name)
      end
      vim.lsp.config(config.lsp.name, config.lsp.opts)
      if config.lsp.name ~= "*" then vim.lsp.enable(config.lsp.name) end
    end
    if config.fmt ~= nil and config.fmt ~= {} then
      if not mason_registry.is_installed(config.fmt.name) then vim.cmd("MasonInstall " .. config.fmt.name) end
      table.insert(Language_util.formatters, config.fmt.opts)
    end
    if config.ide ~= nil and config.ide ~= {} then table.insert(Language_util.ides, config.ide) end
  end
end
Mason_util.custom_capabilities = function(modified_capabilities)
  return function(client, _)
    for capability, value in pairs(modified_capabilities) do
      local current = client.server_capabilities
      for index = 1, #capability - 1 do
        local key = capability[index]
        if current[key] == nil then current[key] = {} end
        current = current[key]
      end
      current[capability[#capability]] = value
    end
  end
end

----------------------------------------------------------------------------------------------------

Diagnostic_util = {}
Diagnostic_util.create_virtual_line_autocmd = function()
  local initial_virtual_text = vim.diagnostic.config().virtual_text
  vim.defer_fn(function()
    vim.api.nvim_create_autocmd("CursorMoved", {
      once = true,
      group = vim.api.nvim_create_augroup("VirtualLineDiagnostic", {}),
      callback = function() vim.diagnostic.config({ virtual_lines = false, virtual_text = initial_virtual_text }) end,
    })
  end, 1)
end
Diagnostic_util.display_virtual_line = function()
  pcall(vim.api.nvim_del_augroup_by_name, "VirtualLineDiagnostic")
  vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
  Diagnostic_util.create_virtual_line_autocmd()
end
Diagnostic_util.jump_virtual_line = function(count)
  pcall(vim.api.nvim_del_augroup_by_name, "VirtualLineDiagnostic")
  vim.diagnostic.jump({ count = count })
  vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
  Diagnostic_util.create_virtual_line_autocmd()
end

----------------------------------------------------------------------------------------------------

Neogit_util = {}
Neogit_util.last_buffer = nil
Neogit_util.open_status_menu = function()
  Neogit_util.last_buffer = vim.bo.filetype
  local cwd = vim.fn.getcwd()
  vim.cmd("Neogit")
  vim.api.nvim_set_current_dir(cwd)
end
Neogit_util.close_status_menu = function(file_explorer)
  if Neogit_util.last_buffer == "netrw" or Neogit_util.last_buffer == "oil" or Neogit_util.last_buffer == nil then
    vim.cmd(file_explorer .. " .")
  else
    vim.api.nvim_input("<C-o>")
  end
end
Neogit_util.copy_current_file_url = function(use_line_number)
  local path = vim.fn.expand("%:p")
  local output = vim.fn.systemlist(table.concat({
    "git rev-parse --is-inside-work-tree && ",
    'git ls-tree HEAD -- "' .. path .. '" && ',
    "git config --get remote.origin.url && ",
    "git rev-parse --abbrev-ref HEAD && ",
    'git ls-files --full-name "' .. path .. '"',
  }, " "))
  local is_git_repo = false
  local exists_in_head = false
  local repo_url = ""
  local branch_name = ""
  local git_file_path = ""
  local count = 1
  for _, line in ipairs(output) do
    if count == 1 then
      if line:gsub("\n", "") == "true" then is_git_repo = true end
    elseif count == 2 then
      if line:find("blob") and vim.bo.filetype ~= "netrw" then exists_in_head = true end
    elseif count == 3 then
      repo_url = line
        :gsub("\n", "")
        :gsub("git@github.com:", "https://github.com/")
        :gsub("git@gitlab.com:", "https://gitlab.com/")
        :gsub("%.git$", "")
    elseif count == 4 then
      branch_name = line:gsub("\n", "")
    elseif count == 5 then
      git_file_path = line:gsub("\n", "")
    end
    count = count + 1
  end
  if not is_git_repo then
    vim.notify("Not in a git repository!", "error")
    return
  end
  if not exists_in_head then
    vim.notify("File not in HEAD!", "error")
    return
  end
  repo_url = repo_url .. "/blob/" .. branch_name .. "/" .. git_file_path
  if not use_line_number then
    vim.fn.setreg("+", repo_url)
    vim.notify("Copied: " .. repo_url)
    return
  end
  local line_number = vim.fn.line(".")
  local buffer_content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local head_content = vim.fn.systemlist('git show HEAD:"' .. git_file_path .. '"')
  local context_threshold = 10
  local found_line_number = false
  for total_context = context_threshold, 0, -1 do
    for above = total_context, 0, -1 do
      local below = total_context - above
      local start_line = math.max(line_number - above, 1)
      local end_line = math.min(line_number + below, #buffer_content)
      local snippet_length = end_line - start_line
      local buffer_snippet = table.concat(buffer_content, "\n", start_line, end_line)
      for j = 1, #head_content - snippet_length do
        local head_snippet = table.concat(head_content, "\n", j, j + snippet_length)
        if buffer_snippet == head_snippet then
          repo_url = repo_url .. "#L" .. (j + (line_number - start_line))
          vim.fn.setreg("+", repo_url)
          vim.notify("Copied: " .. repo_url)
          found_line_number = true
          break
        end
      end
      if found_line_number then break end
    end
    if found_line_number then break end
  end
  if not found_line_number then vim.notify("Line not in HEAD!", "error") end
end

----------------------------------------------------------------------------------------------------

Diffview_util = {}
Diffview_util.fullscreen = function()
  local window = { type = "float" }
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines
  window.border = "none"
  window.width = editor_width
  window.height = editor_height - 1
  window.col = math.floor(editor_width * 0.5 - window.width * 0.5)
  window.row = math.floor(editor_height * 0.5 - window.height * 0.5)
  return window
end

----------------------------------------------------------------------------------------------------

Supermaven_util = {}
Supermaven_util.disable_for_large_files = function(supermaven_api, max_size)
  local size = vim.fn.getfsize(vim.fn.expand("%"))
  if size > max_size and supermaven_api.is_running() then
    vim.cmd("SupermavenStop")
  elseif size <= max_size and not supermaven_api.is_running() then
    vim.cmd("SupermavenStart")
  end
end
