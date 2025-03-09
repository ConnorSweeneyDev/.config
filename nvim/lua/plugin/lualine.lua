require("lualine").setup({
	options = {
		theme = "vscode",
		component_separators = { left = "┃", right = "┃" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		refresh = { statusline = 10, tabline = 10, winbar = 10 },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "dynamic_path", fmt = Lualine_util.dynamic_path } },
		lualine_c = { "diagnostics" },
		lualine_x = { "diff" },
		lualine_y = { { "current_register", fmt = Lualine_util.current_register } },
		lualine_z = { "progress", "location" },
	},
})
