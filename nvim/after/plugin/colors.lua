function SetColors(color)
    color = color or "catppuccin"	
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.cmd("highlight @variable guifg=#D08282")
    vim.cmd("highlight @lsp.type.variable guifg=#D08282")
    vim.cmd("highlight Conditional cterm=NONE gui=NONE")
end

SetColors()
