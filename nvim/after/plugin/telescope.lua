require("telescope").setup{
  defaults = {
    layout_config = {horizontal = {preview_width = 0.5}},
    file_ignore_patterns = {".git\\", ".cache\\", "external\\", "ext\\", "binary\\", "bin\\", "assets\\", ".exe", ".dll",
                            ".class", ".jar", ".sln", ".vcxproj", ".png", ".jpg", ".pyc", "packer_compiled.lua"}
  }
}

local builtin = require("telescope.builtin")
map("n", "<LEADER>pf", function() builtin.find_files({find_command = {"rg", "--files", "--hidden"}}) end, default_opts)
map("n", "<LEADER>ps", function() builtin.grep_string({find_command = {"rg", "--files", "--hidden"}, search = vim.fn.input("Search Term: "), ignorecase = false}); end)
map("n", "<LEADER>pw", function() builtin.grep_string({find_command = {"rg", "--files", "--hidden"}, search = vim.fn.expand("<cword>"), ignorecase = false}); end)
map("n", "<LEADER>pW", function() builtin.grep_string({find_command = {"rg", "--files", "--hidden"}, search = vim.fn.expand("<cWORD>"), ignorecase = false}); end)
map("n", "<LEADER>pb", builtin.buffers)
map("n", "<C-p>", builtin.git_files)
