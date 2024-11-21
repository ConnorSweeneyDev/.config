map("n", "<LEADER>Uc", function() cc_util.switch_file_in_compilation_unit("/program", "c") end)
map("n", "<LEADER>Uh", function() cc_util.switch_file_in_compilation_unit("/program", "h") end)
map("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")
