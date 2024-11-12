require"nvim-treesitter.install".prefer_git = false
require"nvim-treesitter.install".compilers = {"gcc"}
require"nvim-treesitter.configs".setup{
  ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "hurl", "http", "html", "javascript", "css", "java", "c_sharp", "markdown_inline",
                      "cpp", "python", "sql", "xml", "json", "glsl", "cmake", "gitcommit", "gitignore", "diff", "markdown", "regex", "bash"},
  sync_install = false,
  auto_install = false,
  highlight = {enable = true, additional_vim_regex_highlighting = false}
}
local max_size = 200000
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter", "ModeChanged"}, {callback = function() treesitter_util.disable_for_large_files(max_size) end})
