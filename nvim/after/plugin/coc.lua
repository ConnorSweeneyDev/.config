-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

vim.keymap.set("i", "<C-y>", 'coc#pum#confirm()', {expr = true, noremap = true, silent = true, replace_keycodes = false})

vim.keymap.set("n", "<leader>td", ":<C-u>CocList diagnostics<cr>", {silent = true, nowait = true})
vim.keymap.set("n", "[d", "<Plug>(coc-diagnostic-prev)", {silent = true})
vim.keymap.set("n", "]d", "<Plug>(coc-diagnostic-next)", {silent = true})

vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
vim.keymap.set("n", "<leader>ka", "<Plug>(coc-codeaction-cursor)", {silent = true, nowait = true})
