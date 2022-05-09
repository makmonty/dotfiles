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
  "Plug 'ggandor/leap.nvim'
  " Zettelkasten command (zk) integration
  Plug 'mickael-menu/zk-nvim'
endif
