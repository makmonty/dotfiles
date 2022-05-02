packloadall

"" vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set encoding=UTF-8

set updatetime=1000

set mouse=a

filetype plugin on
syntax enable
"set omnifunc=syntaxcomplete#Complete

"" Plugins
call plug#begin()
" Color scheme
Plug 'srcery-colors/srcery-vim'
" Filesystem tree
Plug 'preservim/nerdtree'
" Icons for NERDTree
Plug 'ryanoasis/vim-devicons'
" Git integration for NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Colorize NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Javascript integration
Plug 'pangloss/vim-javascript'
" Vue syntax highlight
Plug 'posva/vim-vue'
" Git plugin
Plug 'tpope/vim-fugitive'
""Plug 'ycm-core/YouCompleteMe'
" Suggestions and completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
""Plug 'scrooloose/syntastic'
" Git marks in the gutter
Plug 'airblade/vim-gitgutter'
" Statusbar
Plug 'vim-airline/vim-airline'
" Typescript integration
Plug 'leafgarland/typescript-vim'
" Editorconfig integration
Plug 'editorconfig/editorconfig-vim'
" Colorize parentheses
Plug 'kien/rainbow_parentheses.vim'
" LSP marks in the gutter
Plug 'w0rp/ale'
" Local vimrc
Plug 'embear/vim-localvimrc'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Show css colors inline
Plug 'ap/vim-css-color'
" Underlines the current word and its appearances
Plug 'itchyny/vim-cursorword'
" Change easily the surrounding characters
Plug 'tpope/vim-surround'
" For writers
Plug 'preservim/vim-pencil'
" Make multiline changes
Plug 'mg979/vim-visual-multi'
" Inline git blame
Plug 'APZelos/blamer.nvim'
" Symbols and tags in a sidebar
Plug 'liuchengxu/vista.vim'
" Comment easily
Plug 'preservim/nerdcommenter'
" Handlebars integration
Plug 'mustache/vim-mustache-handlebars'
"" Nvim only
if has('nvim')
  ""Plug 'ggandor/lightspeed.nvim'
  " Search in the current window
  Plug 'ggandor/leap.nvim'
  " Zettelkasten command (zk) integration
  Plug 'mickael-menu/zk-nvim'
endif
call plug#end()

"" Color schemes
"let g:molokai_original = 1
"colorscheme molokai
"colorscheme monokai
colorscheme srcery
"hi Normal guibg=NONE ctermbg=NONE
" Solarized (not working)
"set background=light
"colorscheme solarized

"" Sessions
"set sessionoptions-=blank
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
""let g:ctrlp_working_path_mode = 'ra'
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

"" CoC
let g:coc_global_extensions = [
    \ 'coc-ember',
    \ 'coc-json',
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ '@yaegassy/coc-volar'
\]

function ToggleNERDTree()
    if expand('%:p') == '' || exists("g:NERDTree") && g:NERDTree.IsOpen()
        execute ":NERDTreeToggle"
    else
        execute ":NERDTreeFind"
    endif
endfunction

"" Keymappings
let mapleader = ","
nnoremap <C-f> :Lines<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <expr> <C-p> isdirectory(".git") ? ":GFiles\<CR>" : ":Files\<CR>"
nnoremap <C-i> :call ToggleNERDTree()<CR>
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
