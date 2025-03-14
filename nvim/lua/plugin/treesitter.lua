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
    "glsl",
    "cmake",
    "gitcommit",
    "vim",
    "gitignore",
    "markdown",
    "regex",
    "bash",
    "rust",
  },
  sync_install = false,
  auto_install = false,
  highlight = { enable = true, additional_vim_regex_highlighting = false },
})
Api.nvim_create_autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, {
  callback = function() Treesitter_util.disable_for_large_files(200000) end,
})
