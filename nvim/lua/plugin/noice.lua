local hidden_messages = {
  "written",
  "lines yanked",
  "more lines",
  "lines indented",
  "; before",
  "; after",
  "Search word with letter:",
  "Match found"
}
require("noice").setup{
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true
    }
  },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = false,
    inc_rename = false,
    lsp_doc_border = false
  },
  routes = noice_util.create_routes(hidden_messages)
}
