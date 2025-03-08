local servers = {
	clangd = {},
	glsl_analyzer = {},
	pyright = {},
	html = {},
	ts_ls = {},
	cssls = {},
	java_language_server = {},
	rust_analyzer = {},
	sqlls = {},
}
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
	handlers = lsp_util.generate_handlers(require("lspconfig"), require("cmp_nvim_lsp"), servers),
})
lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
})
lsp.inlay_hint.enable(false)
diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = {
		severity = {
			diagnostic.severity.ERROR,
			diagnostic.severity.WARN,
			diagnostic.severity.INFO,
			diagnostic.severity.HINT,
		},
	},
	signs = {
		text = {
			[diagnostic.severity.ERROR] = "▌",
			[diagnostic.severity.WARN] = "▌",
			[diagnostic.severity.INFO] = "▌",
			[diagnostic.severity.HINT] = "▌",
		},
	},
})
