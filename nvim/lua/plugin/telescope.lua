require("telescope").setup({
	defaults = {
		layout_config = { horizontal = { height = 1000, width = 1000 } },
		file_ignore_patterns = {
			".git\\",
			".cache\\",
			"external\\",
			"ext\\",
			"binary\\",
			"bin\\",
			"assets\\",
			".exe",
			".dll",
			".class",
			".jar",
			".sln",
			".vcxproj",
			".png",
			".jpg",
			".pyc",
			"packer_compiled.lua",
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
local builtin = require("telescope.builtin")
Map("n", "<LEADER>pf", function()
	builtin.find_files({ find_command = { "rg", "--files", "--hidden" } })
end)
Map("n", "<LEADER>pl", function()
	builtin.live_grep({ find_command = { "rg", "--files", "--hidden" } })
end)
Map("n", "<LEADER>ps", function()
	builtin.grep_string({
		find_command = { "rg", "--files", "--hidden" },
		search = Fn.input("Search Term: "),
		ignorecase = false,
	})
end)
Map("n", "<LEADER>pw", function()
	builtin.grep_string({
		find_command = { "rg", "--files", "--hidden" },
		search = Fn.expand("<cword>"),
		ignorecase = false,
	})
end)
Map("n", "<LEADER>pW", function()
	builtin.grep_string({
		find_command = { "rg", "--files", "--hidden" },
		search = Fn.expand("<cWORD>"),
		ignorecase = false,
	})
end)
Map("n", "<LEADER>pg", builtin.git_files)
Map("n", "<LEADER>pb", builtin.buffers)
