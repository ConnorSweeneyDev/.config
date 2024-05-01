require"nvim-treesitter.install".prefer_git = false
require"nvim-treesitter.install".compilers = { "clang" }

require"nvim-treesitter.configs".setup
{
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "hurl", "http", "html", "javascript", "css", "java", "c_sharp", "markdown_inline",
                         "cpp", "python", "sql", "xml", "json", "glsl", "cmake", "gitcommit", "gitignore", "diff", "markdown", "regex", "bash" },

    sync_install = false,
    auto_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false }
}
