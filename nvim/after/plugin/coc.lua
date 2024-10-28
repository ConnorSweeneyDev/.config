map("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], {expr = true, noremap = true, silent = true, replace_keycodes = false})
map("n", "<LEADER>ka", "<PLUG>(coc-codeaction-cursor)", {silent = true, nowait = true})

map("n", "<LEADER>td", "<CMD>CocList diagnostics --buffer<CR>", {silent = true, nowait = true})
map("n", "<LEADER>tD", "<CMD>CocList diagnostics<CR>", {silent = true, nowait = true})
map("n", "[d", "<PLUG>(coc-diagnostic-prev)", {silent = true})
map("n", "]d", "<PLUG>(coc-diagnostic-next)", {silent = true})

map("n", "gd", "<PLUG>(coc-definition)", {silent = true})
map("n", "gy", "<PLUG>(coc-type-definition)", {silent = true})
map("n", "gr", "<PLUG>(coc-references)", {silent = true})
map("n", "gi", "<PLUG>(coc-implementation)", {silent = true})

function _G.show_docs()
  local cw = vim.fn.expand("<cword>")
  if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
    api.nvim_command("h " .. cw)
  elseif api.nvim_eval("coc#rpc#ready()") then
    vim.fn.CocActionAsync("doHover")
  else
    api.nvim_command("!" .. opt.keywordprg .. " " .. cw)
  end
end
map("n", "K", "<CMD>lua _G.show_docs()<CR>", {silent = true})
map("n", "<C-j>", [[coc#float#has_scroll() ? coc#float#scroll(1, 1) : "<C-j>"]], {expr = true, noremap = true, silent = true, replace_keycodes = false})
map("n", "<C-k>", [[coc#float#has_scroll() ? coc#float#scroll(0, 1) : "<C-k>"]], {expr = true, noremap = true, silent = true, replace_keycodes = false})

map("n", "<LEADER>rn", "<PLUG>(coc-rename)", {silent = true})
map("n", "<LEADER>rN", "<CMD>CocCommand workspace.renameCurrentFile<CR>", {silent = true})
map("n", "<LEADER>rf", "<PLUG>(coc-refactor)", {silent = true})
map("n", "<LEADER>cr", "<CMD>CocRestart<CR>", {silent = true})
