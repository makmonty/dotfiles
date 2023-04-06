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
source ~/.vim/plugins.vim
call plug#end()

"" Color schemes
"let g:molokai_original = 1
"colorscheme molokai
"colorscheme monokai
" colorscheme srcery
colorscheme catppuccin_mocha
hi Normal guibg=NONE ctermbg=NONE
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

"" Keymappings
source ~/.vim/mappings.vim
