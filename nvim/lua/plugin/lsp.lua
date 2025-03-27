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
Map("n", "<LEADER>kr", "<CMD>LspRestart<CR>", { desc = "Restart LSP" })
Map("n", "<LEADER>ka", Lsp.buf.code_action, { desc = "Code action" })
Map("n", "<LEADER>rn", Lsp.buf.rename, { desc = "Rename symbol" })
Map("n", "K", Lsp.buf.hover, { desc = "Popup hover" })
Map(
  "n",
  "<LEADER>e",
  function() Diagnostic.open_float({ scope = "cursor" }) end,
  { desc = "Show diagnostics under cursor" }
)
Map(
  "n",
  "]d",
  function() Diagnostic.jump({ count = 1, wrap = true, float = true }) end,
  { desc = "Go to next diagnostic and show it" }
)
Map(
  "n",
  "[d",
  function() Diagnostic.jump({ count = -1, wrap = true, float = true }) end,
  { desc = "Go to previous diagnostic and show it" }
)
