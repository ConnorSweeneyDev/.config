require("mason").setup()
local mason_registry = require("mason-registry")
Mason_util.install_formatters(mason_registry, {
  ["clang-format"] = {
    cmd = { "clang-format", "-i", "[|]" },
    filetypes = { "c", "h", "cpp", "hpp", "inl", "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" },
  },
  ["black"] = {
    cmd = { "black", "[|]" },
    filetypes = { "py" },
  },
  ["prettier"] = {
    cmd = { "prettier", "[|]", "--write" },
    filetypes = { "js", "jsx", "css", "html", "json", "jsonc" },
  },
  ["stylua"] = {
    cmd = { "stylua", "[|]" },
    filetypes = { "lua" },
  },
})
Mason_util.install_language_servers(mason_registry, {
  ["*"] = { capabilities = require("blink.cmp").get_lsp_capabilities(Lsp.protocol.make_client_capabilities()) },
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
    filetypes = { "python" },
    settings = {
      python = {
        analysis = { autoSearchPaths = true, diagnosticMode = "openFilesOnly", useLibraryCodeForTypes = true },
      },
    },
  },
  ["lua-language-server"] = {
    cmd = { "lua-language-server" },
    root_markers = { ".git", ".luarc.json", ".stylua.toml" },
    filetypes = { "lua" },
    on_attach = Mason_util.custom_capabilities({ [{ "semanticTokensProvider" }] = {} }),
  },
  ["html-lsp"] = {
    cmd = { "vscode-html-language-server", "--stdio" },
    root_markers = { ".git", "package.json" },
    filetypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = { css = true, javascript = true },
    },
  },
  ["typescript-language-server"] = {
    cmd = { "typescript-language-server", "--stdio" },
    root_markers = { ".git", "package.json" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    init_options = { hostInfo = "neovim" },
  },
  ["css-lsp"] = {
    cmd = { "vscode-css-language-server", "--stdio" },
    root_markers = { ".git", "package.json" },
    filetypes = { "css", "scss", "less" },
    settings = { css = { validate = true }, scss = { validate = true }, less = { validate = true } },
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
Map("n", "<LEADER>h", "<CMD>Mason<CR>", { desc = "Open Mason" })
