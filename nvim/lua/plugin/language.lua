map("n", "<LEADER>kf", function() language_util.format() end)
map("n", "<LEADER><LEADER>", function() language_util.source_lua() end)
map("n", "UC", function() c_util.switch_file_in_compilation_unit("source") end)
map("n", "UH", function() c_util.switch_file_in_compilation_unit("header") end)
map("n", "UI", function() c_util.switch_file_in_compilation_unit("inline") end)
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "ModeChanged"},
                            {callback = function() language_util.change_format_options() end})
