require("leap").create_default_mappings()
map({'n', 'x', 'o'}, '<A-s>', function() require('leap-by-word').leap() end)
