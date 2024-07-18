vim.keymap.set("n", "<LEADER>kf", "<CMD>!clang-format -i %<CR>")

function switch_file_in_unit(dir)
  if not string.match(vim.fn.expand("%:e"), "cpp") and not string.match(vim.fn.expand("%:e"), "hpp") then
    vim.notify("Error: Not a cpp or hpp file!", "error")
    return
  end

  local cwd = vim.fn.getcwd()
  local name = vim.fn.expand("%:t:r")
  if string.match(name, "%.tpl$") then
    name = string.gsub(name, "%.tpl$", "")
  end

  local long_files = vim.fn.globpath(dir, "**/" .. name .. ".*", 0, 1)
  local files = {}
  for _, file in ipairs(long_files) do
    local new_file = string.gsub(file, cwd .. "\\", "")
    new_file = string.gsub(new_file, "\\", "/")
    table.insert(files, new_file)
  end

  if #files == 0 then
    vim.notify("Error: Problem reading filename!", "error")

  elseif #files == 1 then
    vim.notify("Error: There is only one file in this compilation unit!", "error")

  elseif #files == 2 then
    local source = ""
    local header = ""

    for _, file in ipairs(files) do
      if string.match(file, "%.cpp$") then
        source = file
      elseif string.match(file, "%.hpp$") then
        header = file
      end
    end

    if string.match(vim.fn.expand("%:e"), "cpp") then
      vim.cmd("edit " .. header)
    else
      vim.cmd("edit " .. source)
    end

  elseif #files == 3 then
    local source = ""
    local header = ""
    local template = ""

    for _, file in ipairs(files) do
      if string.match(file, "%.cpp$") then
        source = file
      elseif string.match(file, "%.tpl.hpp$") then
        template = file
      elseif string.match(file, "%.hpp$") then
        header = file
      end
    end

    local selection = {}
    if string.match(vim.fn.expand("%:e"), "cpp") then
      selection = {header, template}
    elseif string.match(vim.fn.expand("%:e"), "hpp") and string.match(vim.fn.expand("%:t:r"), "%.tpl$") then
      selection = {source, header}
    elseif string.match(vim.fn.expand("%:e"), "hpp") then
      selection = {source, template}
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
