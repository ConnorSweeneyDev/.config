scheme = "vscode"
status_column_separator = " ▎ "
line_colors = {"#DEDEDE", "#BDBDBD", "#9C9C9C", "#7B7B7B", "#5A5A5A"}
highlights = {
  "Directory guibg=NONE",
  "Question guibg=NONE",
  "Conceal guibg=NONE",
  "CocInlayHint guibg=NONE",
  "Error guibg=NONE",
  "ErrorMsg guibg=NONE",
  "DiagnosticWarn guibg=NONE guifg=#FFE88B",
  "WarningMsg guibg=NONE",
  "DiagnosticInfo guibg=NONE guifg=#0A7ACA",
  "DiagnosticHint guibg=NONE guifg=#0A7ACA",
  "DiagnosticUnderlineError gui=underline guifg=#F44747",
  "DiagnosticUnderlineWarn gui=underline guifg=#FFE88B",
  "DiagnosticUnderlineInfo gui=underline guifg=#0A7ACA",
  "DiagnosticUnderlineHint gui=underline guifg=#0A7ACA",
  "MoreMsg guibg=NONE",
  "ModeMsg guibg=NONE",
  "FoldColumn guibg=NONE",
  "DiffAdd guibg=NONE guifg=#4B5632",
  "DiffChange guibg=NONE guifg=#646464",
  "DiffDelete guibg=NONE guifg=#6F1313",
  "SpecialChar guibg=NONE guifg=#D7BA7D"
}

color_util.initialize_colors(scheme, highlights)
api.nvim_create_autocmd({"BufEnter", "WinEnter", "CursorMoved"},
                        {callback = function() color_util.line_number_handler(status_column_separator, line_colors) end})
