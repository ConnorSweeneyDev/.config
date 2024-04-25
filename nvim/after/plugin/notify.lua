require("notify").setup{ timeout = 1000, background_colour = "#000000", fps = 60, render = "minimal", stages = "fade" }

vim.keymap.set("n", "<LEADER>pm", "<CMD>Telescope notify<CR>")
