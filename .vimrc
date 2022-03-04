packloadall

"" vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set encoding=UTF-8

"" Sessions
"set sessionoptions-=blank

"" Plugins
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
""Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'w0rp/ale'
Plug 'embear/vim-localvimrc'
Plug 'ryanoasis/vim-devicons'
call plug#end()

"" Solarized (not working)
syntax enable
"set background=light
"colorscheme solarized

"" Sessions
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction

" Show hidden files in NERDTree
let NERDTreeShowHidden = 1

" Save session on quitting Vim
"autocmd VimLeave * NERDTreeClose
"autocmd VimLeave * call SaveSess()
" Restore session on starting Vim
"autocmd VimEnter * call RestoreSess()
"autocmd VimEnter * NERDTree

"" NERDTree
" Autoopen
"autocmd VimEnter * NERDTree | wincmd p

" Autoopen but only if it's not a session
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | wincmd p | endif

" Keymapping
map <C-n> :NERDTreeToggle<CR>
" Close if it's the only window left
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" CtrlP
let g:ctrlp_working_path_model = 'ra'
""let g:ctrlp_custom_ignore = '(node_modules|dist)'
""set wildignore+=*/node_modules/*,*/dist/*

"" localvimrc
let g:localvimrc_persistent = 1

"" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_javascript_checkers = ['eslint']
