vim.cmd [[packadd packer.nvim]]
return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use{"nvim-lua/plenary.nvim", commit = "a3e3bc8"}
  use{"stevearc/oil.nvim", commit = "fcca212"}
  use{"nvim-telescope/telescope.nvim", commit = "43c47eb"}
  use{"nvim-telescope/telescope-ui-select.nvim", commit = "6e51d7d"}
  use{"theprimeagen/harpoon", branch = "harpoon2", commit = "0378a6c"}
  use{"mbbill/undotree", commit = "56c684a"}
  use{"gbprod/yanky.nvim", commit = "73215b7"}
  use{"kevinhwang91/nvim-bqf", commit = "1b24dc6"}
  use{"itchyny/vim-qfedit", commit = "d05f2f3"}
  use{"ggandor/leap.nvim", commit = "c6bfb19"}

  use{"MunifTanjim/nui.nvim", commit = "61574ce"}
  use{"nvim-tree/nvim-web-devicons", commit = "3722e3d"}
  use{"tribela/vim-transparent", commit = "7b34267"}
  use{"Mofiqul/vscode.nvim", as = "vscode", commit = "7de58b7"}
  use{"nvim-lualine/lualine.nvim", commit = "b431d22"}
  use{"rcarriga/nvim-notify", commit = "d333b6f"}
  use{"folke/noice.nvim", commit = "d9328ef"}

  use{"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use("nvim-treesitter/nvim-treesitter-context")
  use{"neoclide/coc.nvim", branch = "release"}
  use("tpope/vim-fugitive")
  use("github/copilot.vim")
  use{"iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, commit = "a923f5f"}
end)
