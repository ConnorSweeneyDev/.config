local dap = require("dap")
vim.keymap.set("n", "<F5>", function() dap.terminate({ hierarchy = true }) end, { desc = "DAP Terminate" })
vim.keymap.set("n", "<F6>", dap.continue, { desc = "DAP Continue" })
vim.keymap.set("n", "<F7>", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
vim.keymap.set("n", "<F8>", dap.step_over, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F9>", dap.step_into, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F10>", dap.step_out, { desc = "DAP Step Out" })
for _, group in pairs({ "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }) do
  vim.fn.sign_define(group, { text = "●", texthl = group })
end
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "debugPC", numhl = "debugPC" })

require("dap-view").setup({
  winbar = {
    show = true,
    sections = { "console", "watches", "scopes", "exceptions", "breakpoints", "threads" },
    default_section = "console",
  },
  windows = { size = 0.5, position = "below" },
  auto_toggle = true,
})
