require("oil").setup
{
    default_file_explorer = false,
    skip_confirm_for_simple_edits = false,
    view_options =
    {
        show_hidden = true,
        is_hidden_file = function(name, bufnr) return vim.startswith(name, ".") end,
    },
    keymaps =
    {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = false,
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = false,
        ["~"] = false,
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
    }
}

vim.cmd("Oil")
