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
vim.keymap.set({ "n", "v" }, "<LEADER>ac", "<CMD>CodeCompanionChat<CR>", { desc = "Open CodeCompanion chat" })
vim.keymap.set({ "n", "v" }, "<LEADER>ai", "<CMD>CodeCompanion<CR>", { desc = "Run CodeCompanion inline" })
vim.keymap.set({ "n", "v" }, "<LEADER>ad", "<CMD>CodeCompanion /lsp<CR>", { desc = "Run CodeCompanion lsp" })
vim.keymap.set({ "n", "v" }, "<LEADER>ae", "<CMD>CodeCompanion /explain<CR>", { desc = "Run CodeCompanion explain" })
vim.keymap.set({ "n", "v" }, "<LEADER>ag", "<CMD>CodeCompanion /commit<CR>", { desc = "Run CodeCompanion commit" })
