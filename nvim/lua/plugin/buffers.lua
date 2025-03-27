Buffer_util.set_parameters({ "/program", "/asset/shader", "/src", "/lua" }, {
  "*.cpp",
  "*.hpp",
  "*.inl",
  "*.glsl",
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
Map("n", "<A-o>", function() Buffer_util.manual_open() end, { desc = "Open all buffers matching the search criteria" })
Map("n", "<A-c>", function() Buffer_util.manual_close() end, { desc = "Close all buffers except the current one" })
Buffer_util.open_on_startup()
