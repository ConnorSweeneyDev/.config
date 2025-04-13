Map("n", "<LEADER>kf", function() Language_util.format("%") end, { desc = "Format current buffer" })
Map("n", "<LEADER>kF", function() Language_util.format(".") end, { desc = "Format current directory" })
Map("n", "<LEADER><LEADER>", function() Lua_util.source() end, { desc = "Source current lua file" })
Map(
  "n",
  "<LEADER>uc",
  function() C_util.switch_file_in_compilation_unit("source") end,
  { desc = "Switch to source file in compilation unit" }
)
Map(
  "n",
  "<LEADER>uh",
  function() C_util.switch_file_in_compilation_unit("header") end,
  { desc = "Switch to header file in compilation unit" }
)
Map(
  "n",
  "<LEADER>ui",
  function() C_util.switch_file_in_compilation_unit("inline") end,
  { desc = "Switch to inline file in compilation unit" }
)
Map("n", "<C-w>c", function() C_util.open_visual_studio() end, { desc = "Open the current solution in Visual Studio" })
Api.nvim_create_autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, {
  callback = function()
    Language_util.handle_text({ "txt", "md", "gitcommit" })
    Language_util.handle_gitcommit(72)
  end,
})
