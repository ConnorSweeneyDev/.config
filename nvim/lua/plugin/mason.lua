require("mason").setup()
Mason_util.setup_languages(require("mason-registry"), {
  ["*"] = {
    lsp = {
      name = "*",
      opts = {
        capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
      },
    },
  },
  ["C/C++"] = {
    lsp = {
      name = "clangd",
      opts = {
        cmd = { "clangd", "--background-index" },
        root_markers = { "compile_commands.json", "compile_flags.txt", "CMakeLists.txt", ".git" },
        filetypes = { "c", "h", "cpp", "hpp", "inl", "objc", "objcpp", "cuda", "proto" },
      },
    },
    fmt = {
      name = "clang-format",
      opts = {
        cmd = { "clang-format", "-i", "[|]" },
        filetypes = { "c", "h", "cpp", "hpp", "inl", "objc", "objcpp", "cuda", "proto" },
      },
    },
    ide = {
      name = "Visual Studio",
      opts = {
        cmd = { "devenv", "[|]" },
        targets = { "*.sln", "build/*.sln" },
        filetypes = { "c", "h", "cpp", "hpp", "inl", "objc", "objcpp", "cuda", "proto" },
      },
    },
  },
  ["HLSL"] = {
    fmt = {
      name = "clang-format",
      opts = {
        cmd = { "clang-format", "-i", "[|]" },
        filetypes = { "hlsl", "glsl", "vert", "frag", "comp", "geom", "tesc", "tese" },
      },
    },
    ide = {
      name = "Visual Studio",
      opts = {
        cmd = { "devenv", "[|]" },
        targets = { "*.sln", "build/*.sln" },
        filetypes = { "hlsl", "glsl", "vert", "frag", "comp", "geom", "tesc", "tese" },
      },
    },
  },
  ["Python"] = {
    lsp = {
      name = "pyright",
      opts = {
        cmd = { "pyright-langserver", "--stdio" },
        root_markers = { "pyrightconfig.json", "pyproject.toml", ".git" },
        filetypes = { "python" },
        settings = {
          python = {
            analysis = { autoSearchPaths = true, diagnosticMode = "openFilesOnly", useLibraryCodeForTypes = true },
          },
        },
      },
    },
    fmt = {
      name = "black",
      opts = {
        cmd = { "black", "[|]" },
        filetypes = { "py", "python" },
      },
    },
  },
  ["Lua"] = {
    lsp = {
      name = "lua-language-server",
      opts = {
        cmd = { "lua-language-server" },
        root_markers = { ".luarc.json", ".stylua.toml", ".git" },
        filetypes = { "lua" },
        settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } },
        on_attach = function(client, _) client.server_capabilities.semanticTokensProvider = {} end,
      },
    },
    fmt = {
      name = "stylua",
      opts = {
        cmd = { "stylua", "[|]" },
        filetypes = { "lua" },
      },
    },
  },
  ["HTML"] = {
    lsp = {
      name = "html-lsp",
      opts = {
        cmd = { "vscode-html-language-server", "--stdio" },
        root_markers = { "package.json", ".git" },
        filetypes = { "html" },
        init_options = {
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = { css = true, javascript = true },
        },
      },
    },
    fmt = {
      name = "prettier",
      opts = {
        cmd = { "prettier", "[|]", "--write" },
        filetypes = { "html" },
      },
    },
  },
  ["TypeScript"] = {
    lsp = {
      name = "typescript-language-server",
      opts = {
        cmd = { "typescript-language-server", "--stdio" },
        root_markers = { "package.json", ".git" },
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
    },
    fmt = {
      name = "prettier",
      opts = {
        cmd = { "prettier", "[|]", "--write" },
        filetypes = {
          "js",
          "jsx",
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      },
    },
  },
  ["CSS"] = {
    lsp = {
      name = "css-lsp",
      opts = {
        cmd = { "vscode-css-language-server", "--stdio" },
        root_markers = { "package.json", ".git" },
        filetypes = { "css", "scss", "less" },
        settings = { css = { validate = true }, scss = { validate = true }, less = { validate = true } },
      },
    },
    fmt = {
      name = "prettier",
      opts = {
        cmd = { "prettier", "[|]", "--write" },
        filetypes = { "css", "scss", "less" },
      },
    },
  },
  ["JSON"] = {
    lsp = {
      name = "json-lsp",
      opts = {
        cmd = { "vscode-json-language-server", "--stdio" },
        root_markers = { ".git" },
        filetypes = { "json", "jsonc" },
      },
    },
    fmt = {
      name = "prettier",
      opts = {
        cmd = { "prettier", "[|]", "--write" },
        filetypes = { "json", "jsonc" },
      },
    },
  },
  ["SQL"] = {
    lsp = {
      name = "sqlls",
      opts = {
        cmd = { "sql-language-server", "up", "--method", "stdio" },
        root_markers = { ".git" },
        filetypes = { "sql", "mysql" },
      },
    },
  },
})
vim.keymap.set("n", "<LEADER>h", "<CMD>Mason<CR>", { desc = "Open Mason" })
