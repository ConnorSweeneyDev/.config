local function assign_files(long_files, cwd)
  local files = {}
  for _, file in ipairs(long_files) do
    local new_file = string.gsub(file, cwd .. "\\", "")
    new_file = string.gsub(new_file, "\\", "/")
    table.insert(files, new_file)
  end

  return files
end

local function assign_cc_file_types(files)
  local source = ""
  local header = ""

  for _, file in ipairs(files) do
    if string.match(file, "%.c$") then
      source = file
    elseif string.match(file, "%.h$") then
      header = file
    end
  end

  return source, header
end

function switch_file_in_cc_unit(dir)
  if not string.match(vim.fn.expand("%:e"), "c") and not string.match(vim.fn.expand("%:e"), "h") then
    vim.notify("Not a C source or header file!", "error")
    return
  end

  local cwd = vim.fn.getcwd()
  local name = vim.fn.expand("%:t:r")
  local long_files = vim.fn.globpath(dir, "**/" .. name .. ".*", 0, 1)
  local files = assign_files(long_files, cwd)

  if #files == 0 then
    vim.notify("Problem reading filename!", "error")

  elseif #files == 1 then
    vim.notify("There is only one file in this compilation unit!", "error")

  elseif #files == 2 then
    local source, header = assign_cc_file_types(files)
    local other_file = ""

    if string.match(vim.fn.expand("%:e"), "c") then
      other_file = header
    elseif string.match(vim.fn.expand("%:e"), "h") then
      other_file = source
    else
      vim.notify("Unexpected file extension!", "error")
      return
    end
    vim.cmd("edit " .. other_file)

  else
    vim.notify("Unexpectedly high amount of corresponding files found!", "error")
  end
end
map("n", "<LEADER>pU", function() switch_file_in_cc_unit(vim.fn.getcwd() .. "/program") end)
                      -- Folder to recursively search for files in the compilation unit ^^^

map("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")
