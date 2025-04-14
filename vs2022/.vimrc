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
nnoremap gr :vsc Edit.FindAllReferences<CR>
nnoremap <LEADER>td :vsc View.ErrorList<CR>
nnoremap <LEADER>to :vsc View.Output<CR>

nnoremap <LEADER>v :vsc Build.CleanSolution<CR>
nnoremap <LEADER>b :vsc Build.BuildSolution<CR>
nnoremap <LEADER>n :vsc Debug.StartWithoutDebugging<CR>
nnoremap <LEADER>m :vsc Debug.Start<CR>
nnoremap <LEADER>k :vsc Debug.StopDebugging<CR>

nnoremap <LEADER>tb :vsc Debug.ToggleBreakpoint<CR>
nnoremap s :vsc Debug.StepOver<CR>
nnoremap S :vsc Debug.StepInto<CR>
nnoremap <LEADER>s :vsc Debug.StepOut<CR>

nnoremap <LEADER>fn :vsc Project.AddNewItem<CR>
nnoremap <LEADER>fe :vsc Project.AddExistingItem<CR>
