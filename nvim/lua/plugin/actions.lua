local actions = require("actions-preview")
actions.setup()
api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		map("n", "<LEADER>ka", actions.code_actions, { buffer = event.buf })
		map("n", "<LEADER>rn", lsp.buf.rename, { buffer = event.buf })
		map("n", "K", lsp.buf.hover, { buffer = event.buf })
	end,
})
map("n", "<LEADER>h", "<CMD>Mason<CR>")
map("n", "<LEADER>cr", "<CMD>LspRestart<CR>")
