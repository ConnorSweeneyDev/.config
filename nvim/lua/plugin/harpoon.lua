local harpoon = require("harpoon")
harpoon:setup({ settings = { save_on_toggle = true } })
Map(
  "n",
  "<C-e>",
  function()
    harpoon.ui:toggle_quick_menu(harpoon:list(), { title = " Harpoon ", title_pos = "left", border = "rounded" })
  end,
  { desc = "Open Harpoon" }
)
Map("n", "<LEADER>a", function() harpoon:list():add() end, { desc = "Add current file to harpoon" })
Map("n", "<LEADER>z", function() harpoon:list():remove() end, { desc = "Remove current file from harpoon" })
Map("n", "<C-z>", function() harpoon:list():clear() end, { desc = "Remove all files from harpoon" })
Map("n", "<C-g>", function() harpoon:list():select(1) end, { desc = "Go to first harpoon file" })
Map("n", "<C-h>", function() harpoon:list():select(2) end, { desc = "Go to second harpoon file" })
Map("n", "<C-y>", function() harpoon:list():select(3) end, { desc = "Go to third harpoon file" })
Map("n", "<C-l>", function() harpoon:list():select(4) end, { desc = "Go to fourth harpoon file" })
