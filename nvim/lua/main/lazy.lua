lazy_util.bootstrap()
map("n", "<LEADER>l", "<CMD>Lazy<CR>")
require("lazy").setup
{
  {"nvim-lua/plenary.nvim"},
  {"divagueame/lacasitos.nvim"},
  {"stevearc/oil.nvim"},
  {"nvim-telescope/telescope.nvim"},
  {"theprimeagen/harpoon", branch = "harpoon2"},
  {"mbbill/undotree"},
  {"gbprod/yanky.nvim"},
  {"ggandor/leap.nvim"},
  {"Sleepful/leap-by-word.nvim"},
  {"kevinhwang91/nvim-bqf"},
  {"itchyny/vim-qfedit"},
  {"MunifTanjim/nui.nvim"},
  {"nvim-tree/nvim-web-devicons"},
  {"tribela/vim-transparent"},
  {"Mofiqul/vscode.nvim", name = "vscode"},
  {"nvim-lualine/lualine.nvim"},
  {"rcarriga/nvim-notify"},
  {"folke/noice.nvim"},
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {"neoclide/coc.nvim", branch = "release"},
  {"tpope/vim-fugitive"},
  {"github/copilot.vim"}
}
