map("n", "<C-u>c", function() c_util.switch_file_in_compilation_unit("/program", "source") end)
map("n", "<C-u>h", function() c_util.switch_file_in_compilation_unit("/program", "header") end)
map("n", "<C-u>i", function() c_util.switch_file_in_compilation_unit("/program", "inline") end)
map("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")
