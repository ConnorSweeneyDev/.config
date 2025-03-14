local cmp = require("cmp")
cmp.setup({
	preselect = cmp.PreselectMode.None,
	completion = { completeopt = "menu,menuone,noinsert,noselect" },
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
	},
	sources = {
		{ name = "path" },
		{ name = "buffer" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
	},
})
