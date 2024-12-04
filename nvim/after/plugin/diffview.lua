require("diffview").setup {
  show_help_hints = false,
  view = {
    merge_tool = {
      layout = "diff3_mixed",
      disable_diagnostics = true,
      winbar_info = true
    }
  },
  file_panel = {
    win_config = {
      position = "left",
      width = 16
    }
  }
}
