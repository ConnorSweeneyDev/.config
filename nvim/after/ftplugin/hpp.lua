map("n", "<C-u>c", function() cxx_util.switch_file_in_compilation_unit("/program", "cpp") end)
map("n", "<C-u>h", function() cxx_util.switch_file_in_compilation_unit("/program", "hpp") end)
map("n", "<C-u>i", function() cxx_util.switch_file_in_compilation_unit("/program", "inl") end)
map("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")
