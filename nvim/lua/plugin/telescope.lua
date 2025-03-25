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
Map(
  "n",
  "<LEADER>pf",
  function() builtin.find_files({ find_command = { "rg", "--files", "--hidden" } }) end,
  { desc = "Fuzzy find filenames" }
)
Map(
  "n",
  "<LEADER>pl",
  function() builtin.live_grep({ find_command = { "rg", "--files", "--hidden" }, ignorecase = false }) end,
  { desc = "Fuzzy find in filenames and files live" }
)
Map(
  "n",
  "<LEADER>ps",
  function()
    builtin.grep_string({
      find_command = { "rg", "--files", "--hidden" },
      search = Fn.input("Search Term: "),
      ignorecase = false,
    })
  end,
  { desc = "Fuzzy find in files, then filenames" }
)
Map(
  "n",
  "<LEADER>pw",
  function()
    builtin.grep_string({
      find_command = { "rg", "--files", "--hidden" },
      search = Fn.expand("<cword>"),
      ignorecase = false,
    })
  end,
  { desc = "Fuzzy find in files the current word" }
)
Map(
  "n",
  "<LEADER>pW",
  function()
    builtin.grep_string({
      find_command = { "rg", "--files", "--hidden" },
      search = Fn.expand("<cWORD>"),
      ignorecase = false,
    })
  end,
  { desc = "Fuzzy find in files the current WORD" }
)
Map("n", "<LEADER>pg", builtin.git_files, { desc = "Fuzzy find git filenames" })
Map("n", "<LEADER>pb", builtin.buffers, { desc = "Fuzzy find buffer filenames" })
Map("n", "<LEADER>pk", builtin.keymaps, { desc = "Fuzzy find keymaps" })
