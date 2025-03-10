require("supermaven-nvim").setup({
	color = { suggestion_color = "#999999", cterm = 244 },
	keymaps = {
		accept_suggestion = "<Tab>",
		clear_suggestion = "<A-n>",
		accept_word = "<A-m>",
	},
})
Api.nvim_create_autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, {
	callback = function()
		Supermaven_util.disable_for_large_files(require("supermaven-nvim.api"), 200000)
	end,
})
