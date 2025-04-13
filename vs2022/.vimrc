set number
set relativenumber
set incsearch
set scrolloff=1000

let g:mapleader=" "
nnoremap <LEADER>pf :vsc Edit.GoToFile<CR>
nnoremap <LEADER>ps :vsc Edit.GoToText<CR>
nnoremap <LEADER>pm :vsc Edit.GoToMember<CR>
nnoremap <LEADER>pt :vsc Edit.GoToType<CR>
nnoremap gd :vsc Edit.GoToDefinition<CR>
nnoremap gD :vsc Edit.GoToDeclaration<CR>
