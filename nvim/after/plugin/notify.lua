require("notify").setup{ timeout = 1500, background_colour = "#000000", fps = 144, render = "minimal", stages = "static" }

vim.keymap.set("n", "<LEADER>pm", "<CMD>Telescope notify<CR>")
