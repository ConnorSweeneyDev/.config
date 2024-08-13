function open_buffers()
  -- List of folders and file extensions to search for and open
  local folders = {"/program", "/prog", "/lua", "/after", "/script"}
  local file_extensions = {"*.cpp", "*.hpp", "*.c", "*.h", "*.glsl", "*.cs", "*.java", "*.py", "*.lua", "*.bat"}
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

function close_buffers()
  local original_buffer = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if buffer ~= original_buffer then
      vim.api.nvim_buf_delete(buffer, {force = true})
    end
  end
end

open_buffers()
vim.cmd("bd 1")

vim.keymap.set("n", "<A-o>", function() open_buffers() end)
vim.keymap.set("n", "<A-c>", function() close_buffers() end)
