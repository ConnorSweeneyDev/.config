require("telescope").setup{
  defaults = {
    layout_config = {horizontal = {height = 0.99, width = 0.99}},
    file_ignore_patterns = {".git\\", ".cache\\", "external\\", "ext\\", "binary\\", "bin\\", "assets\\", ".exe",
                            ".dll", ".class", ".jar", ".sln", ".vcxproj", ".png", ".jpg", ".pyc", "packer_compiled.lua"}
  },
  extensions = {coc = {timeout = 3000}}
}
require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")
map("n", "<LEADER>pf", function() builtin.find_files({find_command = {"rg", "--files", "--hidden"}}) end, default_opts)
map("n", "<LEADER>pl", function() builtin.live_grep({find_command = {"rg", "--files", "--hidden"}}) end, default_opts)
map("n", "<LEADER>ps", function()
  builtin.grep_string({find_command = {"rg", "--files", "--hidden"},
                       search = vim.fn.input("Search Term: "),
                       ignorecase = false});
end)
map("n", "<LEADER>pw", function()
  builtin.grep_string({find_command = {"rg", "--files", "--hidden"},
                       search = vim.fn.expand("<cword>"),
                       ignorecase = false});
end)
map("n", "<LEADER>pW", function()
  builtin.grep_string({find_command = {"rg", "--files", "--hidden"},
                       search = vim.fn.expand("<cWORD>"),
                       ignorecase = false});
end)
map("n", "<LEADER>pg", builtin.git_files)
map("n", "<LEADER>pb", builtin.buffers)
