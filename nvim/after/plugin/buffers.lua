function OpenBuffers()
  local file_extensions = {'*.cpp', '*.hpp', '*.c', '*.h', '*.glsl', '*.cs', '*.java', '*.py'}
  local original_buffer = vim.api.nvim_get_current_buf()

  for _, ext in ipairs(file_extensions) do
    local files = vim.fn.globpath(vim.fn.getcwd() .. '/prog', '**/' .. ext, 0, 1)
    for _, file in ipairs(files) do
      vim.cmd('edit ' .. file)
    end
  end

  vim.api.nvim_set_current_buf(original_buffer)
end

OpenBuffers()
