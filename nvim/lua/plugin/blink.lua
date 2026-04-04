vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") } })
require("blink.cmp").setup({
  keymap = { preset = "enter", ["<C-j>"] = { "scroll_documentation_down" }, ["<C-k>"] = { "scroll_documentation_up" } },
  sources = { default = { "lsp", "path", "buffer" } },
  appearance = { nerd_font_variant = "normal" },
  completion = {
    documentation = { auto_show = true },
    list = { selection = { preselect = false, auto_insert = true } },
  },
})
