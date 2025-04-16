local telescope = require("telescope")
local builtin = require("telescope.builtin")
telescope.setup({
  defaults = {
    layout_config = { horizontal = { height = 1000, width = 1000 } },
    file_ignore_patterns = {
      ".git\\",
      ".cache\\",
      "external\\",
      "ext\\",
      "binary\\",
      "bin\\",
      "assets\\",
      ".exe",
      ".dll",
      ".class",
      ".jar",
      ".sln",
      ".vcxproj",
      ".png",
      ".jpg",
      ".pyc",
      "packer_compiled.lua",
    },
  },
  extensions = { ["ui-select"] = { require("telescope.themes").get_cursor() } },
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
vim.keymap.set(
  "n",
  "<LEADER>pf",
  function() builtin.find_files({ find_command = { "rg", "--files", "--hidden" } }) end,
  { desc = "Fuzzy find filenames" }
)
vim.keymap.set(
  "n",
  "<LEADER>pl",
  function() builtin.live_grep({ find_command = { "rg", "--files", "--hidden" }, ignorecase = false }) end,
  { desc = "Fuzzy find in filenames and files live" }
)
vim.keymap.set(
  "n",
  "<LEADER>ps",
  function()
    builtin.grep_string({
      find_command = { "rg", "--files", "--hidden" },
      search = vim.fn.input("Search Term: "),
      ignorecase = false,
    })
  end,
  { desc = "Fuzzy find in files, then filenames" }
)
vim.keymap.set(
  "n",
  "<LEADER>pw",
  function()
    builtin.grep_string({
      find_command = { "rg", "--files", "--hidden" },
      search = vim.fn.expand("<cword>"),
      ignorecase = false,
    })
  end,
  { desc = "Fuzzy find in files the current word" }
)
vim.keymap.set(
  "n",
  "<LEADER>pW",
  function()
    builtin.grep_string({
      find_command = { "rg", "--files", "--hidden" },
      search = vim.fn.expand("<cWORD>"),
      ignorecase = false,
    })
  end,
  { desc = "Fuzzy find in files the current WORD" }
)
vim.keymap.set("n", "<LEADER>pg", builtin.git_files, { desc = "Fuzzy find git filenames" })
vim.keymap.set("n", "<LEADER>pb", builtin.buffers, { desc = "Fuzzy find buffer filenames" })
vim.keymap.set("n", "<LEADER>pk", builtin.keymaps, { desc = "Fuzzy find keymaps" })
vim.keymap.set("n", "<LEADER>ph", builtin.help_tags, { desc = "Fuzzy find help" })
