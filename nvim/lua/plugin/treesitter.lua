require("nvim-treesitter").setup({ install_dir = vim.fn.stdpath("data") .. "/site" })
require("nvim-treesitter").install({
  "vim",
  "vimdoc",
  "lua",
  "diff",
  "query",
  "hurl",
  "http",
  "html",
  "javascript",
  "css",
  "java",
  "cpp",
  "c",
  "markdown_inline",
  "c_sharp",
  "python",
  "sql",
  "xml",
  "json",
  "yaml",
  "toml",
  "hlsl",
  "cmake",
  "gitcommit",
  "gitignore",
  "markdown",
  "regex",
  "bash",
})
vim.treesitter.language.register("hlsl", { "glsl", "vert", "frag", "comp", "geom", "tesc", "tese" })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = "*.hlsl,*.glsl,*.vert,*.frag,*.comp,*.geom,*.tesc,*.tese",
  callback = function() vim.bo.commentstring = "// %s" end,
})
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, { callback = function() vim.treesitter.start() end })
