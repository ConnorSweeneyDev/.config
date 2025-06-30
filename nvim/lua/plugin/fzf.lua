local ignore_patterns = {
  ".git/",
  ".cache/",
  "external/",
  "assets/",
  ".exe",
  ".dll",
  ".class",
  ".jar",
  ".sln",
  ".vcxproj",
  ".png",
  ".jpg",
  ".pyc",
}
local fzf = require("fzf-lua")
fzf.setup({
  { "hide" },
  keymap = {
    builtin = {
      ["<A-j>"] = "preview-down",
      ["<A-k>"] = "preview-up",
      ["<A-d>"] = "preview-page-down",
      ["<A-u>"] = "preview-page-up",
      ["<C-r>"] = "preview-reset",
    },
    fzf = {
      ["ctrl-d"] = "half-page-down",
      ["ctrl-u"] = "half-page-up",
    },
  },
  winopts = {
    fullscreen = true,
    border = { "▁", "▁", "▁", "▕", "▕", "", "", "" },
    title_flags = false,
    preview = {
      layout = "horizontal",
      horizontal = "right:70%",
      border = { "▁", "▁", "▁", "", "", "", "▏", "▏" },
    },
  },
  fzf_opts = { ["--layout"] = false },
  fzf_colors = true,
  files = {
    fd_opts = Fzf_util.generate_fd_opts("--color=never --hidden --type f", ignore_patterns),
    rg_opts = Fzf_util.generate_rg_opts("--color=never --hidden --files", ignore_patterns),
  },
  grep = {
    rg_opts = Fzf_util.generate_rg_opts(
      "--column --line-number --no-heading --color=always --smart-case --max-columns=4096",
      ignore_patterns
    ) .. " -e",
    hidden = true,
    winopts = {
      title = false,
      border = { "▁", "▁", "▁", "", "", "", "", "" },
      preview = {
        layout = "vertical",
        vertical = "up:60%",
        border = { "▁", "▁", "▁", "", "", "", "", "" },
      },
    },
  },
  keymaps = {
    winopts = {
      title = false,
      border = { "▁", "▁", "▁", "", "", "", "", "" },
      preview = {
        layout = "vertical",
        vertical = "up:25%",
        border = { "▁", "▁", "▁", "", "", "", "", "" },
      },
    },
  },
})
fzf.register_ui_select()
vim.keymap.set("n", "<LEADER>pf", function() fzf.files() end, { desc = "Find files in project" })
vim.keymap.set("n", "<LEADER>ps", function() fzf.grep() end, { desc = "Search substring in project" })
vim.keymap.set("n", "<LEADER>pw", function() fzf.grep_cword() end, { desc = "Search word under cursor in project" })
vim.keymap.set("n", "<LEADER>pW", function() fzf.grep_cWORD() end, { desc = "Search WORD under cursor in project" })
vim.keymap.set("n", "<LEADER>pl", function() fzf.live_grep() end, { desc = "Live search substring in project" })
vim.keymap.set("n", "<LEADER>pg", function() fzf.git_files() end, { desc = "Find files in git repository" })
vim.keymap.set("n", "<LEADER>pb", function() fzf.buffers() end, { desc = "Find open buffers" })
vim.keymap.set("n", "<LEADER>pk", function() fzf.keymaps() end, { desc = "Show keymaps" })
vim.keymap.set("n", "<LEADER>ph", function() fzf.help_tags() end, { desc = "Show help tags" })
