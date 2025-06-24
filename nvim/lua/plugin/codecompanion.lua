require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "copilot",
      keymaps = {
        close = { modes = { n = "ZZ" } },
      },
    },
    inline = {
      adapter = "copilot",
      keymaps = {
        accept_change = { modes = { n = "<LEADER>aa" } },
        reject_change = { modes = { n = "<LEADER>ar" } },
      },
    },
    cmd = { adapter = "copilot" },
  },
  display = {
    chat = {
      window = { layout = "horizontal", position = "bottom", height = 0.3 },
      auto_scroll = false,
      intro_message = "",
    },
    diff = { layout = "horizontal" },
  },
})
vim.keymap.set("n", "<leader>ac", "<CMD>CodeCompanionChat<CR>", { desc = "Open CodeCompanion" })
vim.keymap.set("v", "<leader>ac", "<CMD>'<,'>CodeCompanionChat<CR>", { desc = "Open CodeCompanion with selection" })
vim.keymap.set("v", "<leader>al", "<CMD>'<,'>CodeCompanion /lsp<CR>", { desc = "Run CodeCompanion lsp" })
vim.keymap.set("v", "<leader>ae", "<CMD>'<,'>CodeCompanion /explain<CR>", { desc = "Run CodeCompanion explain" })
vim.keymap.set("v", "<leader>ai", "<CMD>'<,'>CodeCompanion<CR>", { desc = "Run CodeCompanion inline" })
