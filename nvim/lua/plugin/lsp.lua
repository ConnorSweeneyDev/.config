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
Api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    Map("n", "<LEADER>ka", Lsp.buf.code_action, { buffer = event.buf, desc = "Code action" })
    Map("n", "<LEADER>rn", Lsp.buf.rename, { buffer = event.buf, desc = "Rename symbol" })
    Map("n", "K", Lsp.buf.hover, { buffer = event.buf, desc = "Popup hover" })
    Map(
      "n",
      "<LEADER>e",
      function() Diagnostic_util.display_virtual_line() end,
      { buffer = event.buf, desc = "Show diagnostics under cursor" }
    )
    Map(
      "n",
      "]d",
      function() Diagnostic_util.jump_virtual_line(1) end,
      { buffer = event.buf, desc = "Go to next diagnostic and show it" }
    )
    Map(
      "n",
      "[d",
      function() Diagnostic_util.jump_virtual_line(-1) end,
      { buffer = event.buf, desc = "Go to previous diagnostic and show it" }
    )
  end,
})
