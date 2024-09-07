function set_colors(color)
  color = color or "vscode"
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  -- Specific to vscode color scheme with transparent background
  vim.cmd("highlight Directory guibg=NONE")
  vim.cmd("highlight Question guibg=NONE")
  vim.cmd("highlight Conceal guibg=NONE")
  vim.cmd("highlight CocInlayHint guibg=NONE")
  vim.cmd("highlight Error guibg=NONE")
  vim.cmd("highlight ErrorMsg guibg=NONE")
  vim.cmd("highlight DiagnosticWarn guibg=NONE guifg=#ffe88b")
  vim.cmd("highlight WarningMsg guibg=NONE")
  vim.cmd("highlight DiagnosticInfo guibg=NONE guifg=#0a7aca")
  vim.cmd("highlight DiagnosticHint guibg=NONE guifg=#0a7aca")
  vim.cmd("highlight MoreMsg guibg=NONE")
  vim.cmd("highlight ModeMsg guibg=NONE")
  vim.cmd("highlight FoldColumn guibg=NONE")
  vim.cmd("highlight DiffAdd guibg=NONE guifg=#4b5632")
  vim.cmd("highlight DiffChange guibg=NONE guifg=#646464")
  vim.cmd("highlight DiffDelete guibg=NONE guifg=#6f1313")
end

set_colors()

vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"},
{
  callback = function()
    local separator = " ▎ "
    vim.opt.statuscolumn =
    '%s%=%#LineNr4#%{(v:relnum >= 4)?v:relnum.\"' .. separator .. '\":\"\"}' ..
    '%#LineNr3#%{(v:relnum == 3)?v:relnum.\"' .. separator .. '\":\"\"}' ..
    '%#LineNr2#%{(v:relnum == 2)?v:relnum.\"' .. separator .. '\":\"\"}' ..
    '%#LineNr1#%{(v:relnum == 1)?v:relnum.\"' .. separator .. '\":\"\"}' ..
    '%#LineNr0#%{(v:relnum == 0)?v:lnum.\"' .. separator .. '\":\"\"}'

    vim.cmd("highlight LineNr0 guifg=#dedede")
    vim.cmd("highlight LineNr1 guifg=#bdbdbd")
    vim.cmd("highlight LineNr2 guifg=#9c9c9c")
    vim.cmd("highlight LineNr3 guifg=#7b7b7b")
    vim.cmd("highlight LineNr4 guifg=#5a5a5a")
  end
})
