vim.keymap.set("n", " ", "<NOP>")
vim.keymap.set("n", "<LEADER>w", "<CMD>w<CR>", { desc = "Write" })
vim.keymap.set("n", "<LEADER>W", "<CMD>wa<CR>", { desc = "Write all" })
vim.keymap.set("n", "<LEADER>tw", "<CMD>set wrap!<CR>", { desc = "Toggle wrap" })
vim.keymap.set("n", "L", "<CMD>set relativenumber!<CR>", { desc = "Toggle relative line numbers" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Concatenate the line below to the current line" })
vim.keymap.set("n", "gJ", "mzgJ`z", { desc = "Concatenate the line below to the current line with no space" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move the highlighted line(s) down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move the highlighted line(s) up" })
vim.keymap.set({ "n", "v" }, "j", "gj", { desc = "Move the cursor down" })
vim.keymap.set({ "n", "v" }, "k", "gk", { desc = "Move the cursor up" })
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Move the cursor left one window" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Move the cursor down one window" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Move the cursor up one window" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Move the cursor right one window" })
vim.keymap.set("n", "<C-A-h>", "3<C-w><", { desc = "Move the window separator left 3 columns" })
vim.keymap.set("n", "<C-A-j>", "3<C-w>-", { desc = "Move the window separator down 3 lines" })
vim.keymap.set("n", "<C-A-k>", "3<C-w>+", { desc = "Move the window separator up 3 lines" })
vim.keymap.set("n", "<C-A-l>", "3<C-w>>", { desc = "Move the window separator right 3 columns" })
vim.keymap.set({ "n", "v" }, "<LEADER>y", [["+y]], { desc = "Copy to the system clipboard" })
vim.keymap.set({ "n", "v" }, "<LEADER>Y", [["+y$]], { desc = "Copy to the system clipboard" })
vim.keymap.set({ "n", "v" }, "<LEADER>x", [["_x]], { desc = "Delete without copying" })
vim.keymap.set({ "n", "v" }, "<LEADER>X", [["_X]], { desc = "Delete without copying" })
vim.keymap.set({ "n", "v" }, "<LEADER>d", [["_d]], { desc = "Delete without copying" })
vim.keymap.set({ "n", "v" }, "<LEADER>D", [["_D]], { desc = "Delete without copying" })
vim.keymap.set({ "n", "v" }, "<LEADER>c", [["_c]], { desc = "Change without copying" })
vim.keymap.set({ "n", "v" }, "<LEADER>C", [["_C]], { desc = "Change without copying" })
vim.keymap.set("n", "<LEADER>s", ":%s/<C-r><C-w>/<C-r><C-w>", { desc = "Replace word under cursor within the buffer" })
vim.keymap.set("n", "<C-s>", ":%s/", { desc = "Substitution in the current buffer" })
vim.keymap.set("v", "<LEADER>s", '"hy:%s/<C-r>h/<C-r>h', { desc = "Replace selection in the current buffer" })
vim.keymap.set("v", "<C-s>", ":s/", { desc = "Substitution in the current selection" })
vim.keymap.set("v", "<C-n>", ":normal ", { desc = "Perform normal mode actions for each line in the selection" })
vim.keymap.set(
  "n",
  "<LEADER>qg",
  function() Quickfix_util.grep_search(General_util.find_target_directory()) end,
  { desc = "Grep project for search term" }
)
vim.keymap.set(
  "n",
  "<LEADER>qw",
  function() Quickfix_util.grep_word(General_util.find_target_directory()) end,
  { desc = "Grep project for word under cursor" }
)
vim.keymap.set(
  "n",
  "<LEADER>qW",
  function() Quickfix_util.grep_full_word(General_util.find_target_directory()) end,
  { desc = "Grep project for WORD under cursor" }
)
vim.keymap.set(
  "v",
  "<LEADER>q",
  function() Quickfix_util.grep_selection(General_util.find_target_directory()) end,
  { desc = "Grep project for selection" }
)
vim.keymap.set("n", "<C-w>e", "<CMD>!explorer .<CR><CR>", { desc = "Open the current directory in the file explorer" })
vim.keymap.set("n", "<LEADER>v", "<CMD>!sh script/clean.sh<CR>", { desc = "Execute the clean script" })
vim.keymap.set(
  "n",
  "<LEADER>b",
  '<CMD>!wezterm cli spawn --cwd . pwsh -NoExit -Command "sh script/build.sh"<CR><CR>',
  { desc = "Execute the build script" }
)
vim.keymap.set(
  "n",
  "<LEADER>n",
  '<CMD>!wezterm cli spawn --cwd . pwsh -NoExit -Command "sh script/run.sh"<CR><CR>',
  { desc = "Execute the run script" }
)
vim.keymap.set(
  "n",
  "<LEADER>m",
  '<CMD>!wezterm cli spawn --cwd . pwsh -Command "sh script/debug.sh"<CR><CR>',
  { desc = "Execute the debug script" }
)
