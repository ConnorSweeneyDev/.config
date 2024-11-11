scheme = "vscode"
highlights =
{
  "Directory guibg=NONE",
  "Question guibg=NONE",
  "Conceal guibg=NONE",
  "CocInlayHint guibg=NONE",
  "Error guibg=NONE",
  "ErrorMsg guibg=NONE",
  "DiagnosticWarn guibg=NONE guifg=#ffe88b",
  "WarningMsg guibg=NONE",
  "DiagnosticInfo guibg=NONE guifg=#0a7aca",
  "DiagnosticHint guibg=NONE guifg=#0a7aca",
  "DiagnosticUnderlineError gui=underline guifg=#f44747",
  "DiagnosticUnderlineWarn gui=underline guifg=#ffe88b",
  "DiagnosticUnderlineInfo gui=underline guifg=#0a7aca",
  "DiagnosticUnderlineHint gui=underline guifg=#0a7aca",
  "MoreMsg guibg=NONE",
  "ModeMsg guibg=NONE",
  "FoldColumn guibg=NONE",
  "DiffAdd guibg=NONE guifg=#4b5632",
  "DiffChange guibg=NONE guifg=#646464",
  "DiffDelete guibg=NONE guifg=#6f1313",
  "SpecialChar guibg=NONE guifg=#d7ba7d"
}
color_util.initialize_colors(scheme, highlights)
line_colors =
{
  "#dedede",
  "#bdbdbd",
  "#9c9c9c",
  "#7b7b7b",
  "#5a5a5a"
}
api.nvim_create_autocmd({"BufEnter", "WinEnter", "CursorMoved"}, {callback = function() color_util.line_number_handler(line_colors) end})
