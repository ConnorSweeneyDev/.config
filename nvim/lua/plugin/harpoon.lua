local harpoon = require("harpoon")
harpoon:setup({ settings = { save_on_toggle = true } })
Map(
  "n",
  "<C-e>",
  function()
    harpoon.ui:toggle_quick_menu(harpoon:list(), { title = " Harpoon ", title_pos = "left", border = "rounded" })
  end
)
Map("n", "<LEADER>a", function() harpoon:list():add() end)
Map("n", "<LEADER>z", function() harpoon:list():remove() end)
Map("n", "<C-z>", function() harpoon:list():clear() end)
Map("n", "<C-g>", function() harpoon:list():select(1) end)
Map("n", "<C-h>", function() harpoon:list():select(2) end)
Map("n", "<C-y>", function() harpoon:list():select(3) end)
Map("n", "<C-l>", function() harpoon:list():select(4) end)
