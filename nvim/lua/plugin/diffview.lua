local actions = require("diffview.actions")
require("diffview").setup({
  show_help_hints = false,
  view = {
    default = { layout = "diff2_vertical", disable_diagnostics = false, winbar_info = false },
    merge_tool = { layout = "diff3_mixed", disable_diagnostics = true, winbar_info = false },
  },
  file_panel = { listing_style = "tree", win_config = Diffview_util.fullscreen() },
  keymaps = {
    disable_defaults = true,
    help_panel = {
      { "n", "ZZ", actions.close, { desc = "Close Help" } },
      { "n", "<ESC>", actions.close, { desc = "Close Help" } },
    },
    file_panel = {
      { "n", "<TAB>", actions.toggle_files, { desc = "Toggle Files" } },
      { "n", "<CR>", actions.select_entry, { desc = "Select Entry Under Cursor" } },
      { "n", "<ESC>", actions.close, { desc = "Close Files" } },
      { "n", "ZZ", "<CMD>tabclose<CR>", { desc = "Quit Diffview" } },
      { "n", "g?", actions.help({ "file_panel" }), { desc = "Help" } },
    },
    view = {
      { "n", "ZZ", "<CMD>tabclose<CR>", { desc = "Quit Diffview" } },
      { "n", "<TAB>", actions.toggle_files, { desc = "Toggle Files" } },
    },
    diff2 = {
      { { "n", "x" }, "<LEADER>gg", "0do", { desc = "Choose Remote Hunk" } },
      { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Help" } },
    },
    diff3 = {
      { { "n", "x" }, "<LEADER>gh", actions.diffget("ours"), { desc = "Choose Our Hunk" } },
      { { "n", "x" }, "<LEADER>gl", actions.diffget("theirs"), { desc = "Choose Their Hunk" } },
      { "n", "g?", actions.help({ "view", "diff3" }), { desc = "Help" } },
    },
    diff4 = {
      { { "n", "x" }, "<LEADER>gg", actions.diffget("base"), { desc = "Choose Base Hunk" } },
      { { "n", "x" }, "<LEADER>gh", actions.diffget("ours"), { desc = "Choose Our Hunk" } },
      { { "n", "x" }, "<LEADER>gl", actions.diffget("theirs"), { desc = "Choose Their Hunk" } },
      { "n", "g?", actions.help({ "view", "diff4" }), { desc = "Help" } },
    },
  },
})
