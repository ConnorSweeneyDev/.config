local function open_buffers()
  -- List of folders and file extensions to search for and open
  local folders = {"/program", "/src", "/lua", "/after"}
  local file_extensions = {"*.cpp", "*.hpp", "*.c", "*.h", "*.glsl", "*.cs", "*.java", "*.py", "*.lua"}
  local ignore_files = {"resource.hpp", "resource.cpp"}

  local original_buffer = vim.api.nvim_get_current_buf()
  for _, folder in ipairs(folders) do
    for _, extension in ipairs(file_extensions) do
      local files = vim.fn.globpath(vim.fn.getcwd() .. folder, "**/" .. extension, 0, 1)
      for _, file in ipairs(files) do
        if not vim.tbl_contains(ignore_files, vim.fn.fnamemodify(file, ":t")) then
          vim.cmd("edit " .. file)
        end
      end
    end
  end
  vim.api.nvim_set_current_buf(original_buffer)
end
function clean_open()
  open_buffers()
  vim.cmd("CocRestart")
end
vim.keymap.set("n", "<A-o>", function() clean_open() end)

local function close_buffers()
  local original_buffer = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if buffer ~= original_buffer then
      vim.api.nvim_buf_delete(buffer, {force = true})
    end
  end
end
function clean_close()
  close_buffers()
  vim.cmd("CocRestart")
end
vim.keymap.set("n", "<A-c>", function() clean_close() end)

local function floating_window_exists()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then return true end
  end
  return false
end
local function open_on_startup()
  local original_buffer = vim.api.nvim_get_current_buf()
  open_buffers()
  vim.cmd("bd 1")
  vim.api.nvim_set_current_buf(original_buffer)
end
if not floating_window_exists() then open_on_startup() end
