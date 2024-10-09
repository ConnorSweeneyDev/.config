local lacasitos = require("lacasitos")

local function assign_files(long_files, cwd)
  local files = {}
  for _, file in ipairs(long_files) do
    local new_file = string.gsub(file, cwd .. "\\", "")
    new_file = string.gsub(new_file, "\\", "/")
    table.insert(files, new_file)
  end

  return files
end

local function assign_cxx_file_types(files)
  local source = ""
  local header = ""
  local inline = ""

  for _, file in ipairs(files) do
    if string.match(file, "%.cpp$") then
      source = file
    elseif string.match(file, "%.hpp$") then
      header = file
    elseif string.match(file, "%.inl$") then
      inline = file
    end
  end

  return source, header, inline
end

local function find_one_from_two(file1, file2)
  if file1 ~= "" then
    return file1
  elseif file2 ~= "" then
    return file2
  end
end

function switch_file_in_cxx_unit(dir)
  if not string.match(vim.fn.expand("%:e"), "cpp") and not string.match(vim.fn.expand("%:e"), "hpp") and not string.match(vim.fn.expand("%:e"), "inl") then
    vim.notify("Not a C++ source, header or inline file!", "error")
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
    local source, header, inline = assign_cxx_file_types(files)
    local other_file = ""

    if string.match(vim.fn.expand("%:e"), "cpp") then
      other_file = find_one_from_two(header, inline)
    elseif string.match(vim.fn.expand("%:e"), "hpp") then
      other_file = find_one_from_two(source, inline)
    elseif string.match(vim.fn.expand("%:e"), "inl") then
      other_file = find_one_from_two(source, header)
    else
      vim.notify("Unexpected file extension!", "error")
      return
    end
    vim.cmd("edit " .. other_file)

  elseif #files == 3 then
    local source, header, inline = assign_cxx_file_types(files)
    local selection = {}

    if string.match(vim.fn.expand("%:e"), "cpp") then
      selection = {header, inline}
    elseif string.match(vim.fn.expand("%:e"), "hpp") then
      selection = {source, inline}
    elseif string.match(vim.fn.expand("%:e"), "inl") then
      selection = {source, header}
    else
      vim.notify("Unexpected file extension!", "error")
      return
    end

    local extension_selection = {}
    for _, file in ipairs(selection) do
      table.insert(extension_selection, string.match(file, "%.([^.]+)$"))
    end
    local choice = lacasitos.choose_option(extension_selection)
    if choice then
      if choice == string.match(selection[1], "%.([^.]+)$") then vim.cmd("edit " .. selection[1])
      else vim.cmd("edit " .. selection[2]) end
    end

  else
    vim.notify("Unexpectedly high amount of corresponding files found!", "error")
  end
end
vim.keymap.set("n", "<LEADER>pu", function() switch_file_in_cxx_unit(vim.fn.getcwd() .. "/program") end)
                       -- Folder to recursively search for files in the compilation unit ^^^

vim.keymap.set("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")
