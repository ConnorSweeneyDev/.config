local actions = require("diffview.actions")
require("diffview").setup {
  show_help_hints = false,
  view = {
    merge_tool = {
      layout = "diff3_mixed",
      disable_diagnostics = true,
      winbar_info = false
    }
  },
  file_panel = {
    win_config = {
      position = "top",
      height = 8
    }
  },
  keymaps = {
    diff2 = {
      {{"n", "x"}, "<LEADER>gg", "0do"},
      {"n", "g?", actions.help({"view", "diff2"})}
    },
    diff3 = {
      {{"n", "x"}, "<LEADER>gh", actions.diffget("ours")},
      {{"n", "x"}, "<LEADER>gl", actions.diffget("theirs")},
      {"n", "g?", actions.help({"view", "diff3"})}
    },
    diff4 = {
      {{"n", "x"}, "<LEADER>gg", actions.diffget("base")},
      {{"n", "x"}, "<LEADER>gh", actions.diffget("ours")},
      {{"n", "x"}, "<LEADER>gl", actions.diffget("theirs")},
      {"n", "g?", actions.help({"view", "diff3"})}
    }
  }
}
