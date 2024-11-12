require("supermaven-nvim").setup{
  color = {suggestion_color = "#999999", cterm = 244},
  keymaps = {
    accept_suggestion = "<Tab>",
    clear_suggestion = "<A-n>",
    accept_word = "<A-m>"
  }
}
local max_size = 200000
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "InsertEnter"},
                            {callback = function() supermaven_util.disable_for_large_files(max_size) end})
