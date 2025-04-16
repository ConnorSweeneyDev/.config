vim.lsp.inlay_hint.enable(false)
vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true,
  virtual_text = false,
  virtual_lines = false,
  underline = true,
  float = { source = "if_many" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "▌",
      [vim.diagnostic.severity.WARN] = "▌",
      [vim.diagnostic.severity.INFO] = "▌",
      [vim.diagnostic.severity.HINT] = "▌",
    },
  },
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    vim.keymap.set("n", "<LEADER>ka", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code action" })
    vim.keymap.set("n", "<LEADER>rn", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename symbol" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Popup hover" })
    vim.keymap.set(
      "n",
      "<LEADER>e",
      function() Diagnostic_util.display_virtual_line() end,
      { buffer = event.buf, desc = "Show diagnostics under cursor" }
    )
    vim.keymap.set(
      "n",
      "]d",
      function() Diagnostic_util.jump_virtual_line(1) end,
      { buffer = event.buf, desc = "Go to next diagnostic and show it" }
    )
    vim.keymap.set(
      "n",
      "[d",
      function() Diagnostic_util.jump_virtual_line(-1) end,
      { buffer = event.buf, desc = "Go to previous diagnostic and show it" }
    )
  end,
})
