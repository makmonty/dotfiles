packloadall

"" vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set encoding=UTF-8

set updatetime=1000

filetype plugin on
syntax enable

"" Color schemes
" Monokai
colorscheme monokai
" Solarized (not working)
"set background=light
"colorscheme solarized

"" Sessions
"set sessionoptions-=blank

"" Plugins
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ap/vim-css-color'
Plug 'itchyny/vim-cursorword'
Plug 'tpope/vim-surround'
Plug 'preservim/vim-pencil'
Plug 'mg979/vim-visual-multi'
Plug 'APZelos/blamer.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'preservim/nerdcommenter'
Plug 'mustache/vim-mustache-handlebars'
call plug#end()

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

" Close if it's the only window left
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" CtrlP
let g:ctrlp_working_path_mode = 'ra'
"set wildignore+=*/node_modules/*,*/dist/*

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

"" Visual Multi

"" Blamer
let g:blamer_enabled = 1
let g:blamer_delay = 500
""highlight Blamer guifg=DarkGrey

"" Keymappings
map <C-F> :Rg<CR>
"map <C-p> :GFiles<CR>
map <C-i> :NERDTreeToggle<CR>
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
