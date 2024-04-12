function SetColors(color)
    color = color or "vscode"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- Specific to vscode color scheme
    vim.cmd("highlight Directory guibg=NONE")
    vim.cmd("highlight Question guibg=NONE")
    vim.cmd("highlight Conceal guibg=NONE")
    vim.cmd("highlight Error guibg=NONE")
    vim.cmd("highlight ErrorMsg guibg=NONE")
    vim.cmd("highlight WarningMsg guibg=NONE")
    vim.cmd("highlight MoreMsg guibg=NONE")
    vim.cmd("highlight ModeMsg guibg=NONE")
    vim.cmd("highlight FoldColumn guibg=NONE")
    vim.cmd("highlight DiffAdd guibg=NONE guifg=#4b5632")
    vim.cmd("highlight DiffChange guibg=NONE guifg=NONE")
    vim.cmd("highlight DiffDelete guibg=NONE guifg=#6f1313")
end

SetColors()
