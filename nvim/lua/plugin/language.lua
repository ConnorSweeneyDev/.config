Map(
  "n",
  "<LEADER>kf",
  function()
    Language_util.format({
      [{ "c", "h", "cpp", "hpp", "inl" }] = "clang-format -i %",
      [{ "py" }] = "black %",
      [{ "js", "jsx", "css", "html", "json" }] = "npx prettier % --write",
      [{ "lua" }] = "stylua %",
      [{ "rs" }] = "rustfmt %",
    })
  end,
  { desc = "Format current buffer" }
)
Map("n", "<LEADER><LEADER>", function() Lua_util.source() end, { desc = "Source current lua file" })
Map(
  "n",
  "UC",
  function() C_util.switch_file_in_compilation_unit("source") end,
  { desc = "Switch to source file in compilation unit" }
)
Map(
  "n",
  "UH",
  function() C_util.switch_file_in_compilation_unit("header") end,
  { desc = "Switch to header file in compilation unit" }
)
Map(
  "n",
  "UI",
  function() C_util.switch_file_in_compilation_unit("inline") end,
  { desc = "Switch to inline file in compilation unit" }
)
Api.nvim_create_autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, {
  callback = function()
    Language_util.handle_text({ "txt", "md", "gitcommit" })
    Language_util.handle_gitcommit(72)
  end,
})
