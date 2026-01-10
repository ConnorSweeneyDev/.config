vim.g.opencode_opts = { provider = { enabled = false } }
local opencode = require("opencode")
vim.keymap.set({ "n", "x" }, "<LEADER>ot", function() opencode.prompt("@this") end, { desc = "Opencode this" })
vim.keymap.set({ "n", "x" }, "<LEADER>ov", function() opencode.prompt("@visible") end, { desc = "Opencode visible" })
vim.keymap.set({ "n", "x" }, "<LEADER>ob", function() opencode.prompt("@buffer") end, { desc = "Opencode buffer" })
vim.keymap.set({ "n", "x" }, "<LEADER>od", function() opencode.prompt("@diagnostics") end, { desc = "Opencode errors" })
vim.keymap.set({ "n", "x" }, "<LEADER>og", function() opencode.prompt("@diff") end, { desc = "Opencode git diff" })
