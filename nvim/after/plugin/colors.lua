function SetColors(color)
	color = color or "onedark"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.cmd("highlight @punctuation.bracket guifg=#999999")
    vim.cmd("highlight @punctuation.delimiter guifg=#999999")
end

SetColors()
