Lazy_util.bootstrap()
vim.keymap.set("n", "<LEADER>l", "<CMD>Lazy<CR>", { desc = "Open Lazy" })
require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "stevearc/oil.nvim" },
  { "ibhagwan/fzf-lua" },
  { "mbbill/undotree" },
  { "gbprod/yanky.nvim" },
  { "echasnovski/mini.surround" },
  { "stevearc/quicker.nvim" },
  { "kevinhwang91/nvim-bqf" },
  { "Mofiqul/vscode.nvim", name = "vscode" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-treesitter/nvim-treesitter", branch = "master", build = ":TSUpdate" },
  { "williamboman/mason.nvim" },
  { "saghen/blink.cmp", version = "*" },
  { "folke/trouble.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "sindrets/diffview.nvim" },
  { "NeogitOrg/neogit" },
  { "github/copilot.vim" },
})
