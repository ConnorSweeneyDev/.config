require("telescope").setup
{
  defaults =
  {
    -- Ignore any string that has the following patterns
    file_ignore_patterns = { ".git\\", ".cache\\", "external\\", "assets\\", ".exe", ".dll", ".so.0",
                             ".class", ".jar", ".sln", ".vcxproj", ".png", ".jpg", ".pyc", "packer_compiled.lua" }
  }
}
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<LEADER>pf", function() builtin.find_files({ find_command = {"rg", "--files", "--hidden"} }) end, default_opts)
vim.keymap.set("n", "<LEADER>ps", function() builtin.grep_string({ search = vim.fn.input("Search Term: "), ignorecase = false }); end)
vim.keymap.set("n", "<LEADER>pb", builtin.buffers, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
