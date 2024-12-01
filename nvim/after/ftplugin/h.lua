map("n", "UC", function() c_util.switch_file_in_compilation_unit("/program", "source") end)
map("n", "UH", function() c_util.switch_file_in_compilation_unit("/program", "header") end)
map("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")
