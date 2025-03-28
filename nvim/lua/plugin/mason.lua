require("mason").setup()
Map("n", "<LEADER>h", "<CMD>Mason<CR>", { desc = "Open Mason" })
Mason_util.install_and_enable(require("mason-registry"), {
  ["clangd"] = {
    cmd = { "clangd", "--background-index" },
    root_markers = { ".git", "compile_commands.json", "compile_flags.txt" },
    filetypes = { "c", "h", "cpp", "hpp", "inl", "objc", "objcpp", "cuda", "proto" },
  },
  ["glsl_analyzer"] = {
    cmd = { "glsl_analyzer" },
    root_markers = { ".git", "compile_commands.json", "compile_flags.txt" },
    filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" },
  },
  ["pyright"] = {
    cmd = { "pyright-langserver", "--stdio" },
    root_markers = { ".git", "pyrightconfig.json", "pyproject.toml" },
    settings = {
      python = {
        analysis = { autoSearchPaths = true, diagnosticMode = "openFilesOnly", useLibraryCodeForTypes = true },
      },
    },
    filetypes = { "python" },
  },
  ["lua-language-server"] = {
    cmd = { "lua-language-server" },
    root_markers = { ".git", ".luarc.json", ".stylua.toml" },
    filetypes = { "lua" },
  },
  ["html-lsp"] = {
    cmd = { "vscode-html-language-server", "--stdio" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = { css = true, javascript = true },
    },
    root_markers = { ".git", "package.json" },
    filetypes = { "html" },
  },
  ["typescript-language-server"] = {
    cmd = { "typescript-language-server", "--stdio" },
    init_options = { hostInfo = "neovim" },
    root_markers = { ".git", "package.json" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  ["css-lsp"] = {
    cmd = { "vscode-css-language-server", "--stdio" },
    root_markers = { ".git", "package.json" },
    filetypes = { "css", "scss", "less" },
    settings = { css = { validate = true }, scss = { validate = true }, less = { validate = true } },
  },
  ["rust-analyzer"] = {
    cmd = { "rust-analyzer" },
    root_markers = { ".git", "cargo.toml", "rustfmt.toml" },
    filetypes = { "rust" },
  },
  ["json-lsp"] = {
    cmd = { "vscode-json-language-server", "--stdio" },
    root_markers = { ".git" },
    filetypes = { "json", "jsonc" },
  },
  ["sqlls"] = {
    cmd = { "sql-language-server", "up", "--method", "stdio" },
    root_markers = { ".git" },
    filetypes = { "sql", "mysql" },
  },
})
