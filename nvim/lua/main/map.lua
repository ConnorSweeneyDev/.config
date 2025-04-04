Map("n", " ", "<NOP>")
Map("n", "<LEADER>w", "<CMD>w<CR>", { desc = "Write" })
Map("n", "<LEADER>W", "<CMD>wa<CR>", { desc = "Write all" })
Map("n", "<LEADER>tw", "<CMD>set wrap!<CR>", { desc = "Toggle wrap" })
Map("n", "J", "mzJ`z", { desc = "Concatenate the line below to the end of the current line" })
Map("n", "gJ", "mzgJ`z", { desc = "Concatenate the line below to the end of the current line without a space" })
Map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move the highlighted line(s) down" })
Map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move the highlighted line(s) up" })
Map({ "n", "v" }, "j", "gj", { desc = "Move the cursor down" })
Map({ "n", "v" }, "k", "gk", { desc = "Move the cursor up" })
Map("n", "<A-h>", "<C-w>h", { desc = "Move the cursor left one window" })
Map("n", "<A-j>", "<C-w>j", { desc = "Move the cursor down one window" })
Map("n", "<A-k>", "<C-w>k", { desc = "Move the cursor up one window" })
Map("n", "<A-l>", "<C-w>l", { desc = "Move the cursor right one window" })
Map("n", "<C-A-h>", "3<C-w><", { desc = "Move the window separator left 3 columns" })
Map("n", "<C-A-j>", "3<C-w>-", { desc = "Move the window separator down 3 lines" })
Map("n", "<C-A-k>", "3<C-w>+", { desc = "Move the window separator up 3 lines" })
Map("n", "<C-A-l>", "3<C-w>>", { desc = "Move the window separator right 3 columns" })
Map({ "n", "v" }, "<LEADER>y", [["+y]], { desc = "Copy to the system clipboard" })
Map({ "n", "v" }, "<LEADER>Y", [["+Y]], { desc = "Copy to the system clipboard" })
Map({ "x", "v" }, "<LEADER>p", [["_dP]], { desc = "Paste over text without copying it" })
Map({ "n", "v" }, "<LEADER>x", [["_x]], { desc = "Delete without copying" })
Map({ "n", "v" }, "<LEADER>X", [["_X]], { desc = "Delete without copying" })
Map({ "n", "v" }, "<LEADER>d", [["_d]], { desc = "Delete without copying" })
Map({ "n", "v" }, "<LEADER>D", [["_D]], { desc = "Delete without copying" })
Map({ "n", "v" }, "<LEADER>c", [["_c]], { desc = "Change without copying" })
Map({ "n", "v" }, "<LEADER>C", [["_C]], { desc = "Change without copying" })
Map("n", "<LEADER>s", ":%s/<C-r><C-w>/<C-r><C-w>", { desc = "Replace word under cursor in the current buffer" })
Map("n", "<C-s>", ":%s/", { desc = "Substitution in the current buffer" })
Map("v", "<LEADER>s", '"hy:%s/<C-r>h/<C-r>h', { desc = "Replace selection in the current buffer" })
Map("v", "<C-s>", ":s/", { desc = "Substitution in the current selection" })
Map("v", "<C-n>", ":normal ", { desc = "Perform normal mode actions for each line in the selection" })
Map("n", "<LEADER>qo", "<CMD>copen<CR>", { desc = "Open the quickfix list" })
Map(
  "n",
  "<LEADER>qr",
  function() Quickfix_util.rename() end,
  { desc = "Substitute inside each line in the quickfix list" }
)
Map(
  "n",
  "<LEADER>qg",
  function() Quickfix_util.grep_search(General_util.find_target_directory()) end,
  { desc = "Grep project for search term" }
)
Map(
  "n",
  "<LEADER>qw",
  function() Quickfix_util.grep_word(General_util.find_target_directory()) end,
  { desc = "Grep project for word under cursor" }
)
Map(
  "n",
  "<LEADER>qW",
  function() Quickfix_util.grep_full_word(General_util.find_target_directory()) end,
  { desc = "Grep project for WORD under cursor" }
)
Map(
  "v",
  "<LEADER>q",
  function() Quickfix_util.grep_selection(General_util.find_target_directory()) end,
  { desc = "Grep project for selection" }
)
Map("n", "<C-w>e", "<CMD>!explorer .<CR>", { desc = "Open the current directory in the file explorer" })
Map("n", "<LEADER>v", "<CMD>!sh script/clean.sh<CR>", { desc = "Execute the clean script" })
Map(
  "n",
  "<LEADER>b",
  '<CMD>!wezterm cli spawn --cwd . pwsh -NoExit -Command "sh script/build.sh"<CR>',
  { desc = "Execute the build script" }
)
Map(
  "n",
  "<LEADER>n",
  '<CMD>!wezterm cli spawn --cwd . pwsh -NoExit -Command "sh script/run.sh"<CR>',
  { desc = "Execute the run script" }
)
Map(
  "n",
  "<LEADER>m",
  '<CMD>!wezterm cli spawn --cwd . pwsh -Command "sh script/debug.sh"<CR>',
  { desc = "Execute the debug script" }
)
