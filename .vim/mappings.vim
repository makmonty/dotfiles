function ToggleNERDTree()
    if expand('%:p') == '' || exists("g:NERDTree") && g:NERDTree.IsOpen()
        execute ":NERDTreeToggle"
    else
        execute ":NERDTreeFind"
    endif
endfunction

let mapleader = ","
nnoremap <C-f> :Lines<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <expr> <C-p> isdirectory(".git") ? ":GFiles\<CR>" : ":Files\<CR>"
nnoremap <Tab> :call ToggleNERDTree()<CR>
nnoremap <leader><Left> <C-w><Left>
nnoremap <leader><Right> <C-w><Right>
nnoremap <leader><Up> <C-w><Up>
nnoremap <leader><Down> <C-w><Down>
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
