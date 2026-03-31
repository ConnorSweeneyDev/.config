vim.keymap.set("n", "<leader>pu", function() vim.pack.update() end, { desc = "Update plugins" })
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/mbbill/undotree",
  "https://github.com/gbprod/yanky.nvim",
  "https://github.com/echasnovski/mini.surround",
  "https://github.com/stevearc/quicker.nvim",
  "https://github.com/kevinhwang91/nvim-bqf",
  { src = "https://github.com/Mofiqul/vscode.nvim", name = "vscode" },
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/williamboman/mason.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
  "https://github.com/folke/trouble.nvim",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/github/copilot.vim",
})
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})
