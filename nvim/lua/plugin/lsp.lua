Lsp.inlay_hint.enable(false)
Diagnostic.config({
  update_in_insert = true,
  severity_sort = true,
  virtual_text = false,
  virtual_lines = false,
  underline = true,
  float = { source = "if_many" },
  signs = {
    text = {
      [Diagnostic.severity.ERROR] = "▌",
      [Diagnostic.severity.WARN] = "▌",
      [Diagnostic.severity.INFO] = "▌",
      [Diagnostic.severity.HINT] = "▌",
    },
  },
})
Map("n", "<LEADER>cr", "<CMD>LspRestart<CR>")
Map("n", "<LEADER>ka", Lsp.buf.code_action)
Map("n", "<LEADER>rn", Lsp.buf.rename)
Map("n", "K", Lsp.buf.hover)
Map("n", "<LEADER>e", function() Diagnostic.open_float({ scope = "cursor" }) end)
