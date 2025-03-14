require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = Lsp_util.set_servers({
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
  }),
  automatic_installation = true,
  handlers = Lsp_util.generate_handlers(require("lspconfig"), require("cmp_nvim_lsp")),
})
Map("n", "<LEADER>h", "<CMD>Mason<CR>")
