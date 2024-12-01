map("n", "<C-u>C", function() cc_util.switch_file_in_compilation_unit("/program", "c") end)
map("n", "<C-u>H", function() cc_util.switch_file_in_compilation_unit("/program", "h") end)
map("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")
