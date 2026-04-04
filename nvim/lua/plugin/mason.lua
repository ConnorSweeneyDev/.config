require("mason").setup()
Mason_util.setup_languages(require("mason-registry"), require("dap"), {
  ["*"] = {
    lsp = {
      name = "*",
      config = "*",
      opts = { capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()) },
    },
  },
  ["C/C++"] = {
    lsp = {
      name = "clangd",
      config = "clangd",
    },
    dap = {
      name = "codelldb",
      config = {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file") end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
      opts = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb.exe",
        detached = false,
      },
      languages = { "c", "cpp" },
    },
    fmt = {
      name = "clang-format",
      opts = {
        cmd = { "clang-format", "-i", "[|]" },
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
  },
  ["Python"] = {
    lsp = {
      name = "pyright",
      config = "pyright",
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
      config = "lua_ls",
      opts = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
          },
        },
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
      config = "html",
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
      config = "ts_ls",
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
      config = "cssls",
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
      config = "jsonls",
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
      config = "sqlls",
    },
  },
})
vim.keymap.set("n", "<LEADER>h", "<CMD>Mason<CR>", { desc = "Open Mason" })
