require("telescope").setup
{
    defaults =
    {
        -- Ignore any string that has the following patterns
        file_ignore_patterns = { ".git\\", "external\\", "assets\\", ".dll", ".class", ".jar", ".sln", ".vcxproj", "packer_compiled", ".png", ".jpg", ".pyc" }
    }
}
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", function() builtin.find_files({ find_command = {"rg", "--files", "--hidden"} }) end, default_opts)
vim.keymap.set("n", "<leader>ps", function() builtin.grep_string({ search = vim.fn.input("Search > "), ignorecase = false }); end)
vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
