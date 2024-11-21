map("n", "<LEADER>uc", function() cxx_util.switch_file_in_compilation_unit("/program", "cpp") end)
map("n", "<LEADER>uh", function() cxx_util.switch_file_in_compilation_unit("/program", "hpp") end)
map("n", "<LEADER>ui", function() cxx_util.switch_file_in_compilation_unit("/program", "inl") end)
map("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")
