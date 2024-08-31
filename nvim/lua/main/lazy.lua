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

vim.keymap.set("n", "<LEADER>l", "<CMD>Lazy<CR>")
require("lazy").setup
{
  {"nvim-lua/plenary.nvim", commit = "a3e3bc8"},
  {"stevearc/oil.nvim", commit = "fcca212"},
  {"nvim-telescope/telescope.nvim", commit = "43c47eb"},
  {"nvim-telescope/telescope-ui-select.nvim", commit = "6e51d7d"},
  {"theprimeagen/harpoon", branch = "harpoon2", commit = "0378a6c"},
  {"mbbill/undotree", commit = "56c684a"},
  {"gbprod/yanky.nvim", commit = "73215b7"},
  {"kevinhwang91/nvim-bqf", commit = "1b24dc6"},
  {"itchyny/vim-qfedit", commit = "d05f2f3"},
  {"ggandor/leap.nvim", commit = "c6bfb19"},

  {"MunifTanjim/nui.nvim", commit = "61574ce"},
  {"nvim-tree/nvim-web-devicons", commit = "3722e3d"},
  {"tribela/vim-transparent", commit = "7b34267"},
  {"Mofiqul/vscode.nvim", as = "vscode", commit = "7de58b7"},
  {"nvim-lualine/lualine.nvim", commit = "b431d22"},
  {"rcarriga/nvim-notify", commit = "d333b6f"},
  {"folke/noice.nvim", commit = "d9328ef"},

  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
  {"nvim-treesitter/nvim-treesitter-context"},
  {"neoclide/coc.nvim", branch = "release"},
  {"tpope/vim-fugitive"},
  {"github/copilot.vim"},
  {"iamcco/markdown-preview.nvim", build = "cd app && npm install", init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }}
}
