map("n", "<LEADER>pU", function() cc_util.switch_file_in_unit(vim.fn.getcwd() .. "/program") end)
map("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")
