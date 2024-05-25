vim.cmd[[packadd packer.nvim]]
return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")
    use("stevearc/oil.nvim")
    use("nvim-telescope/telescope.nvim")
    use{"theprimeagen/harpoon", branch = "harpoon2"}
    use("tpope/vim-fugitive")
    use("mbbill/undotree")
    use("gbprod/yanky.nvim")
    use('kevinhwang91/nvim-bqf')
    use("itchyny/vim-qfedit")

    use("ggandor/leap.nvim")
    use("nvim-treesitter/nvim-treesitter-context")

    use{"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use{"neoclide/coc.nvim", branch = "release"}
    use("github/copilot.vim")

    use("nvim-tree/nvim-web-devicons")
    use("MunifTanjim/nui.nvim")
    use("rcarriga/nvim-notify")
    use("tribela/vim-transparent")
    use("nvim-lualine/lualine.nvim")
    use("folke/noice.nvim")
    use{"Mofiqul/vscode.nvim", as = "vscode"}
end)
