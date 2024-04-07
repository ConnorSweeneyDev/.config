require('telescope').setup{
    defaults = {
        file_ignore_patterns = { "src", "assets", ".dll", ".class", ".jar", ".sln", ".vcxproj", "packer_compiled", ".png", ".jpg", ".pyc" }
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
