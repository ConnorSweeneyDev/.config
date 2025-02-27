local actions = require("diffview.actions")
require("diffview").setup{
  show_help_hints = false,
  view = {
    default = {
      layout = "diff2_vertical",
      disable_diagnostics = false,
      winbar_info = false
    },
    merge_tool = {
      layout = "diff3_mixed",
      disable_diagnostics = true,
      winbar_info = false
    }
  },
  file_panel = {
    listing_style = "tree",
    win_config = function()
      local c = { type = "float" }
      local editor_width = vim.o.columns
      local editor_height = vim.o.lines
      c.width = editor_width
      c.height = editor_height
      c.col = math.floor(editor_width * 0.5 - c.width * 0.5)
      c.row = math.floor(editor_height * 0.5 - c.height * 0.5)
      return c
    end
  },
  keymaps = {
    disable_defaults = true,
    help_panel = {
      {"n", "q", actions.close, {desc = "Close Help"}}
    },
    file_panel = {
      {"n", "q", "<CMD>tabclose<CR>", {desc = "Quit Diffview"}},
      {"n", "<TAB>", actions.toggle_files, {desc = "Toggle Files"}},
      {"n", "<CR>", actions.select_entry, {desc = "Select Entry Under Cursor"}},
      {"n", "g?", actions.help({"file_panel"}), {desc = "Help"}}
    },
    view = {
      {"n", "q", "<CMD>tabclose<CR>", {desc = "Quit Diffview"}},
      {"n", "<TAB>", actions.toggle_files, {desc = "Toggle Files"}}
    },
    diff2 = {
      {{"n", "x"}, "<LEADER>gg", "0do", {desc = "Choose Remote Hunk"}},
      {"n", "g?", actions.help({"view", "diff2"}), {desc = "Help"}}
    },
    diff3 = {
      {{"n", "x"}, "<LEADER>gh", actions.diffget("ours"), {desc = "Choose Our Hunk"}},
      {{"n", "x"}, "<LEADER>gl", actions.diffget("theirs"), {desc = "Choose Their Hunk"}},
      {"n", "g?", actions.help({"view", "diff3"}), {desc = "Help"}}
    },
    diff4 = {
      {{"n", "x"}, "<LEADER>gg", actions.diffget("base"), {desc = "Choose Base Hunk"}},
      {{"n", "x"}, "<LEADER>gh", actions.diffget("ours"), {desc = "Choose Our Hunk"}},
      {{"n", "x"}, "<LEADER>gl", actions.diffget("theirs"), {desc = "Choose Their Hunk"}},
      {"n", "g?", actions.help({"view", "diff3"}), {desc = "Help"}}
    }
  }
}
