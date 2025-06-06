vim.keymap.set("n", "<LEADER>kf", function() Language_util.format("%") end, { desc = "Format current buffer" })
vim.keymap.set("n", "<LEADER>kF", function() Language_util.format(".") end, { desc = "Format current directory" })
vim.keymap.set("n", "<C-w>i", function() Language_util.open_ide() end, { desc = "Open IDE for current buffer" })
vim.keymap.set(
  "v",
  "<C-g>",
  function() Language_util.copy_display_text(false) end,
  { desc = "Copy nicely displayed text" }
)
vim.keymap.set(
  "v",
  "g<C-g>",
  function() Language_util.copy_display_text(true) end,
  { desc = "Copy nicely displayed text" }
)
vim.keymap.set("n", "<LEADER><LEADER>", function() Lua_util.source() end, { desc = "Source current lua file" })
vim.keymap.set(
  "n",
  "<LEADER>uc",
  function() C_util.switch_file_in_compilation_unit("source") end,
  { desc = "Switch to source file in compilation unit" }
)
vim.keymap.set(
  "n",
  "<LEADER>uh",
  function() C_util.switch_file_in_compilation_unit("header") end,
  { desc = "Switch to header file in compilation unit" }
)
vim.keymap.set(
  "n",
  "<LEADER>ui",
  function() C_util.switch_file_in_compilation_unit("inline") end,
  { desc = "Switch to inline file in compilation unit" }
)
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, {
  callback = function()
    Language_util.handle_text({ "txt", "md", "gitcommit" })
    Language_util.handle_gitcommit(72)
  end,
})
