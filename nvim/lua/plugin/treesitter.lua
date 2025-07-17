require("nvim-treesitter.install").prefer_git = false
require("nvim-treesitter.install").compilers = { "gcc" }
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "lua",
    "diff",
    "vimdoc",
    "query",
    "hurl",
    "http",
    "html",
    "javascript",
    "css",
    "java",
    "cpp",
    "markdown_inline",
    "c_sharp",
    "python",
    "sql",
    "xml",
    "json",
    "yaml",
    "glsl",
    "cmake",
    "gitcommit",
    "vim",
    "gitignore",
    "markdown",
    "regex",
    "bash",
  },
  sync_install = false,
  auto_install = false,
  highlight = { enable = true, additional_vim_regex_highlighting = false },
})
vim.treesitter.language.register("glsl", "hlsl")
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.hlsl",
  callback = function() vim.bo.filetype = "hlsl" end,
})
