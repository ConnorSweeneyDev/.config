local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

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
