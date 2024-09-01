require("leap").create_default_mappings()
vim.keymap.set({'n', 'x', 'o'}, '<A-s>', function() require('leap-by-word').leap() end, {})
