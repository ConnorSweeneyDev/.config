Buffer_util.set_targets({ "/program", "/resource/shader", "/src", "/lua" }, {
  "*.cpp",
  "*.hpp",
  "*.inl",
  "*.hlsl",
  "*.vert",
  "*.frag",
  "*.comp",
  "*.geom",
  "*.tesc",
  "*.tese",
  "*.c",
  "*.h",
  "*.py",
  "*.rs",
  "*.java",
  "*.cs",
  "*.js",
  "*.jsx",
  "*.css",
  "*.lua",
}, General_util.get_patterns_from_gitignore())
vim.keymap.set(
  "n",
  "<A-o>",
  function() Buffer_util.manual_open() end,
  { desc = "Open all buffers matching the search criteria" }
)
vim.keymap.set(
  "n",
  "<A-c>",
  function() Buffer_util.manual_close() end,
  { desc = "Close all buffers except the current one" }
)
Buffer_util.open_on_startup()
