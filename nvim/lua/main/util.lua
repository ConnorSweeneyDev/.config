General_util = {}
General_util.floating_window_exists = function()
	for _, winid in pairs(Api.nvim_tabpage_list_wins(0)) do
		if Api.nvim_win_get_config(winid).zindex then
			return true
		end
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
	if string.find(target_directory, "%.") then
		target_directory = ""
	end
	return target_directory
end
General_util.get_patterns_from_gitignore = function()
	local gitignore = Fn.glob(".gitignore")
	if gitignore == "" then
		return {}
	end
	local lines = Fn.readfile(gitignore)
	local patterns = {}
	for _, line in ipairs(lines) do
		if line ~= "" and line ~= nil and not string.find(line, "^#") then
			table.insert(patterns, line)
		end
	end
	return patterns
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
Buffer_util.open_buffers = function(folders, file_extensions, ignore_patterns)
	local original_buffer = Api.nvim_get_current_buf()
	for _, folder in ipairs(folders) do
		for _, extension in ipairs(file_extensions) do
			local files = General_util.make_relative_files(Fn.globpath(Fn.getcwd() .. folder, "**/" .. extension, 0, 1))
			for _, file in ipairs(files) do
				local valid_file = true
				for _, ignore_pattern in ipairs(ignore_patterns) do
					if string.find(ignore_pattern, "^%.") then
						ignore_pattern = ignore_pattern .. "$"
					end
					ignore_pattern = string.gsub(ignore_pattern, "%.", "%%.")
					ignore_pattern = string.gsub(ignore_pattern, "^%*", "")
					ignore_pattern = string.gsub(ignore_pattern, "%*$", "")
					if string.find(file, ignore_pattern) then
						valid_file = false
						break
					end
				end
				if valid_file then
					Cmd("edit " .. file)
				end
			end
		end
	end
	Api.nvim_set_current_buf(original_buffer)
end
Buffer_util.close_buffers = function()
	local original_buffer = Api.nvim_get_current_buf()
	local buffers = Api.nvim_list_bufs()
	for _, buffer in ipairs(buffers) do
		if buffer ~= original_buffer then
			Api.nvim_buf_delete(buffer, { force = true })
		end
	end
end
Buffer_util.manual_open = function(folders, file_extensions, ignore_patterns)
	Buffer_util.open_buffers(folders, file_extensions, ignore_patterns)
	Cmd("silent LspRestart")
	Notify("Buffers opened.")
end
Buffer_util.manual_close = function()
	Buffer_util.close_buffers()
	Cmd("silent LspRestart")
	Notify("Buffers closed.")
end
Buffer_util.open_on_startup = function(folders, file_extensions, ignore_patterns)
	if General_util.floating_window_exists() then
		return
	end
	Buffer_util.open_buffers(folders, file_extensions, ignore_patterns)
	Cmd("Ex .")
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
	if not match then
		Opt.formatoptions:remove("t")
	end
	if current_filetype == "gitcommit" then
		Opt.textwidth = 72
		Opt.colorcolumn = "72"
	else
		Opt.textwidth = 120
		Opt.colorcolumn = "120"
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
	if target_directory ~= "" then
		target_directory = "\\" .. target_directory
	end
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

Noice_util = {}
Noice_util.generate_routes = function(hidden_messages)
	local routes = {}
	for _, find_string in ipairs(hidden_messages) do
		table.insert(routes, {
			filter = {
				event = "msg_show",
				kind = "",
				find = find_string,
			},
			opts = { skip = true },
		})
	end
	return routes
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
		if not string.find(path, ":/") then
			path = cwd:match("^.*\\(.*)$") .. "\\" .. path
		end
	elseif string.match(filetype, "oil_preview") then
		path = "confirm"
	elseif string.match(filetype, "oil") then
		path = string.gsub(path, "^oil:///", "")
		path = string.sub(path, 0, 1) .. ":" .. string.sub(path, 2)
		path = string.gsub(path, "/", "\\")
		if cwd ~= root .. ":\\" then
			path = string.gsub(path, cwd, cwd:match("^.*\\(.*)$"))
		end
		if Bo.modified then
			path = path .. modified_symbol
		end
	else
		if cwd:match("^.*\\(.*)$") == nil or cwd:match("^.*\\(.*)$") == "" then
			if not string.find(path, root .. ":\\") then
				path = root .. ":\\" .. path
			end
		else
			if not string.find(path, root .. ":\\") then
				path = cwd:match("^.*\\(.*)$") .. "\\" .. path
			end
		end
		if Bo.modified then
			path = path .. modified_symbol
		end
	end
	if string.match(path, "^." .. root .. ":") then
		path = string.gsub(path, "^.", "")
	end
	if string.match(path, "^.\\" .. root .. ":\\") then
		path = string.gsub(path, "^.\\", "")
	end
	path = string.gsub(path, "\\", "/")
	return path
end
Lualine_util.current_register = function()
	local recording_register = Fn.reg_recording()
	if recording_register ~= "" then
		return "@" .. recording_register
	end
	return "@~"
end

----------------------------------------------------------------------------------------------------

Oil_util = {}
Oil_util.open_on_startup = function()
	if General_util.floating_window_exists() then
		return
	end
	Cmd("Oil .")
	for _, buffer in ipairs(Api.nvim_list_bufs()) do
		if Api.nvim_get_option_value("ft", { buf = buffer }) == "" then
			Api.nvim_buf_delete(buffer, { force = true })
			break
		end
	end
end

----------------------------------------------------------------------------------------------------

Treesitter_util = {}
Treesitter_util.disable_for_large_files = function(max_size)
	local size = Fn.getfsize(Fn.expand("%"))
	if size > max_size then
		Cmd("TSBufDisable highlight")
	else
		Cmd("TSBufEnable highlight")
	end
end

----------------------------------------------------------------------------------------------------

Lsp_util = {}
Lsp_util.generate_handlers = function(lspconfig, cmp_nvim_lsp, servers)
	local handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = Tbl_deep_extend(
				"force",
				{},
				Tbl_deep_extend("force", Lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities()),
				server.capabilities or {}
			)
			lspconfig[server_name].setup({})
			lspconfig[server_name].setup(server)
		end,
	}
	return handlers
end

----------------------------------------------------------------------------------------------------

Neogit_util = {}
Neogit_util.open_status_menu = function()
	local cwd = Fn.getcwd()
	Cmd("Neogit")
	Api.nvim_set_current_dir(cwd)
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
