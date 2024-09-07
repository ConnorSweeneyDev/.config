vim.keymap.set("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")

function assign_files(long_files, cwd)
  local files = {}
  for _, file in ipairs(long_files) do
    local new_file = string.gsub(file, cwd .. "\\", "")
    new_file = string.gsub(new_file, "\\", "/")
    table.insert(files, new_file)
  end

  return files
end

function assign_file_types(files)
  local source = ""
  local header = ""
  local template = ""
  local inline = ""

  for _, file in ipairs(files) do
    if string.match(file, "%.cpp$") then
      source = file
    elseif string.match(file, "%.tpl.hpp$") then
      template = file
    elseif string.match(file, "%.inl.hpp$") then
      inline = file
    elseif string.match(file, "%.hpp$") then
      header = file
    end
  end

  return source, header, template, inline
end

function find_one_from_three(file1, file2, file3)
  if file1 ~= "" then
    return file1
  elseif file2 ~= "" then
    return file2
  elseif file3 ~= "" then
    return file3
  end
end

function find_two_from_three(file1, file2, file3)
  selection = {}
  if file1 ~= "" and file2 ~= "" then
    selection = {file1, file2}
  elseif file1 ~= "" and file3 ~= "" then
    selection = {file1, file3}
  elseif file2 ~= "" and file3 ~= "" then
    selection = {file2, file3}
  end

  return selection
end

function switch_file_in_unit(dir)
  if not string.match(vim.fn.expand("%:e"), "cpp") and not string.match(vim.fn.expand("%:e"), "hpp") then
    vim.notify("Error: Not a cpp or hpp file!", "error")
    return
  end

  local cwd = vim.fn.getcwd()
  local name = vim.fn.expand("%:t:r")
  if string.match(name, "%.tpl$") then
    name = string.gsub(name, "%.tpl$", "")
  elseif string.match(name, "%.inl$") then
    name = string.gsub(name, "%.inl$", "")
  end

  local long_files = vim.fn.globpath(dir, "**/" .. name .. ".*", 0, 1)
  local files = assign_files(long_files, cwd)

  if #files == 0 then
    vim.notify("Error: Problem reading filename!", "error")

  elseif #files == 1 then
    vim.notify("Error: There is only one file in this compilation unit!", "error")

  elseif #files == 2 then
    local source, header, template, inline = assign_file_types(files)
    local other_file = ""

    if string.match(vim.fn.expand("%:e"), "cpp") then
      other_file = find_one_from_three(header, template, inline)
    elseif string.match(vim.fn.expand("%:e"), "hpp") and string.match(vim.fn.expand("%:t:r"), "%.tpl$") then
      other_file = find_one_from_three(source, header, inline)
    elseif string.match(vim.fn.expand("%:e"), "hpp") and string.match(vim.fn.expand("%:t:r"), "%.inl$") then
      other_file = find_one_from_three(source, header, template)
    elseif string.match(vim.fn.expand("%:e"), "hpp") then
      other_file = find_one_from_three(source, template, inline)
    else
      vim.notify("Error: Unexpected file extension!", "error")
      return
    end
    vim.cmd("edit " .. other_file)

  elseif #files == 3 then
    local source, header, template, inline = assign_file_types(files)

    local selection = {}
    if string.match(vim.fn.expand("%:e"), "cpp") then
      selection = find_two_from_three(header, template, inline)
    elseif string.match(vim.fn.expand("%:e"), "hpp") and string.match(vim.fn.expand("%:t:r"), "%.tpl$") then
      selection = find_two_from_three(source, header, inline)
    elseif string.match(vim.fn.expand("%:e"), "hpp") and string.match(vim.fn.expand("%:t:r"), "%.inl$") then
      selection = find_two_from_three(source, header, template)
    elseif string.match(vim.fn.expand("%:e"), "hpp") then
      selection = find_two_from_three(source, template, inline)
    else
      vim.notify("Error: Unexpected file extension!", "error")
      return
    end
    vim.ui.select(selection, {prompt = "Choose a file:"}, function(choice) if choice then vim.cmd("edit " .. choice) end end)

  elseif #files == 4 then
    local source, header, template, inline = assign_file_types(files)

    local selection = {}
    if string.match(vim.fn.expand("%:e"), "cpp") then
      selection = {header, template, inline}
    elseif string.match(vim.fn.expand("%:e"), "hpp") and string.match(vim.fn.expand("%:t:r"), "%.tpl$") then
      selection = {source, header, inline}
    elseif string.match(vim.fn.expand("%:e"), "hpp") and string.match(vim.fn.expand("%:t:r"), "%.inl$") then
      selection = {source, header, template}
    elseif string.match(vim.fn.expand("%:e"), "hpp") then
      selection = {source, template, inline}
    else
      vim.notify("Error: Unexpected file extension!", "error")
      return
    end
    vim.ui.select(selection, {prompt = "Choose a file:"}, function(choice) if choice then vim.cmd("edit " .. choice) end end)

  else
    vim.notify("Error: Unexpectedly high amount of corresponding files found!", "error")
  end
end
vim.keymap.set("n", "<LEADER>pu", function() switch_file_in_unit(vim.fn.getcwd() .. "/program") end)
                    -- Folder to recursively search for files in the compilation unit ^^^
