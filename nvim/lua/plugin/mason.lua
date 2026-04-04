vim.pack.add({ "https://github.com/williamboman/mason.nvim" })
require("mason").setup()
vim.keymap.set("n", "<LEADER>h", "<CMD>Mason<CR>", { desc = "Open Mason" })
Mason_util.install(require("mason-registry"), {
  "clangd",
  "codelldb",
  "clang-format",
  "pyright",
  "black",
  "lua-language-server",
  "stylua",
  "html-lsp",
  "prettier",
  "typescript-language-server",
  "css-lsp",
  "json-lsp",
  "sqlls",
})
