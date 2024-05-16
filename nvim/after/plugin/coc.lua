vim.keymap.set("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], {expr = true, noremap = true, silent = true, replace_keycodes = false})

vim.keymap.set("n", "<LEADER>td", "<CMD>CocList diagnostics<cr>", {silent = true, nowait = true})
vim.keymap.set("n", "[d", "<Plug>(coc-diagnostic-prev)", {silent = true})
vim.keymap.set("n", "]d", "<Plug>(coc-diagnostic-next)", {silent = true})

vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})

function _G.show_docs()
    local cw = vim.fn.expand("<cword>")
    if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command("h " .. cw)
    elseif vim.api.nvim_eval("coc#rpc#ready()") then
        vim.fn.CocActionAsync("doHover")
    else
        vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
    end
end
vim.keymap.set("n", "K", "<CMD>lua _G.show_docs()<CR>", {silent = true})

vim.keymap.set("n", "<LEADER>rn", "<Plug>(coc-rename)", {silent = true})
vim.keymap.set("n", "<LEADER>ka", "<Plug>(coc-codeaction-cursor)", {silent = true, nowait = true})
