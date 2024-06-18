function open_buffers()
  -- List of folders and file extensions to search for and open
  local folders = {"/program", "/lua", "/after", "/scripts"}
  local file_extensions = {"*.cpp", "*.hpp", "*.c", "*.h", "*.glsl", "*.cs", "*.java", "*.py", "*.lua", "*.bat"}

  local original_buffer = vim.api.nvim_get_current_buf()

  for _, folder in ipairs(folders) do
    for _, extension in ipairs(file_extensions) do
      local files = vim.fn.globpath(vim.fn.getcwd() .. folder, "**/" .. extension, 0, 1)
      for _, file in ipairs(files) do
        vim.cmd("edit " .. file)
      end
    end
  end

  vim.cmd("bd 1")
  vim.api.nvim_set_current_buf(original_buffer)
end

open_buffers()
