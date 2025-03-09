local servers = {
	clangd = {},
	glsl_analyzer = {},
	pyright = {},
	lua_ls = {},
	html = {},
	jsonls = {},
	ts_ls = {},
	cssls = {},
	java_language_server = {},
	rust_analyzer = {},
	sqlls = {},
}
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = Tbl_keys(servers),
	automatic_installation = true,
	handlers = Lsp_util.generate_handlers(require("lspconfig"), require("cmp_nvim_lsp"), servers),
})
Lsp.handlers["textDocument/publishDiagnostics"] = Lsp.with(Lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
})
Lsp.inlay_hint.enable(false)
Diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = {
		severity = {
			Diagnostic.severity.ERROR,
			Diagnostic.severity.WARN,
			Diagnostic.severity.INFO,
			Diagnostic.severity.HINT,
		},
	},
	signs = {
		text = {
			[Diagnostic.severity.ERROR] = "▌",
			[Diagnostic.severity.WARN] = "▌",
			[Diagnostic.severity.INFO] = "▌",
			[Diagnostic.severity.HINT] = "▌",
		},
	},
})
