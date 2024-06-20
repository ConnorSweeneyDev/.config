function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return "Recording @~"
  else
    return "Recording @" .. recording_register
  end
end

lualine_path = vim.fn.stdpath("config") .. "\\after\\plugin\\lualine.lua"
vim.cmd("so " .. lualine_path)
