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
Map("n", "<LEADER>cr", "<CMD>LspRestart<CR>")
Map("n", "<LEADER>ka", Lsp.buf.code_action)
Map("n", "<LEADER>rn", Lsp.buf.rename)
Map("n", "K", Lsp.buf.hover)
