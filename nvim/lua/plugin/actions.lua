local actions = require("actions-preview")
actions.setup()
Api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		Map("n", "<LEADER>ka", actions.code_actions, { buffer = event.buf })
		Map("n", "<LEADER>rn", Lsp.buf.rename, { buffer = event.buf })
		Map("n", "K", Lsp.buf.hover, { buffer = event.buf })
	end,
})
Map("n", "<LEADER>h", "<CMD>Mason<CR>")
Map("n", "<LEADER>cr", "<CMD>LspRestart<CR>")
