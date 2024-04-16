require("oil").setup({
    default_file_explorer = false,
    skip_confirm_for_simple_edits = false,
    view_options =
    {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
        end,
    },
})

vim.cmd(":Oil")
