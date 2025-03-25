require("notify").setup({
  timeout = 1500,
  background_colour = "#000000",
  fps = 144,
  render = "minimal",
  stages = "static",
})
Map("n", "<LEADER>pm", "<CMD>Telescope notify<CR>", { desc = "View notifications" })
