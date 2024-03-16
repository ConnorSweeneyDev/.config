vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { silent = true })
