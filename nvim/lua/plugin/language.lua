map("n", "<LEADER>kf", function() language_util.format() end)
map("n", "<LEADER><LEADER>", function() language_util.source_lua() end)
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "ModeChanged"},
                            {callback = function() language_util.change_format_options() end})
