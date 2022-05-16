local Plug = require('helpers.plug')

Plug.begin()

-- Color scheme
Plug 'srcery-colors/srcery-vim'
-- Filesystem tree
Plug 'preservim/nerdtree'
-- Icons for NERDTree
Plug 'ryanoasis/vim-devicons'
-- Git integration for NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'
-- Colorize NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
-- Treesitter for syntax highlighting
Plug('nvim-treesitter/nvim-treesitter', { run = vim.fn[':TSUpdate'] })
-- Javascript integration
Plug 'pangloss/vim-javascript'
-- Vue syntax highlight
Plug 'posva/vim-vue'
-- Git plugin
Plug 'tpope/vim-fugitive'
-- Suggestions and completion
Plug('neoclide/coc.nvim', { branch = 'release' })
-- Git marks in the gutter
Plug 'airblade/vim-gitgutter'
-- Statusbar
Plug 'vim-airline/vim-airline'
-- Typescript integration
Plug 'leafgarland/typescript-vim'
-- Editorconfig integration
Plug 'editorconfig/editorconfig-vim'
-- Colorize parentheses
Plug 'kien/rainbow_parentheses.vim'
-- LSP marks in the gutter
Plug 'w0rp/ale'
-- Local vimrc
Plug 'embear/vim-localvimrc'
-- Fuzzy finder
Plug('junegunn/fzf', { run = vim.fn['fzf#install'] })
Plug 'junegunn/fzf.vim'
--Plug 'nvim-lua/plenary.nvim'
--Plug 'nvim-telescope/telescope.nvim'
-- Show css colors inline
Plug 'ap/vim-css-color'
-- Underlines the current word and its appearances
Plug 'itchyny/vim-cursorword'
-- Change easily the surrounding characters
Plug 'tpope/vim-surround'
-- For writers
Plug 'preservim/vim-pencil'
-- Make multiline changes
Plug 'mg979/vim-visual-multi'
-- Inline git blame
Plug 'APZelos/blamer.nvim'
-- Symbols and tags in a sidebar
Plug 'liuchengxu/vista.vim'
-- Comment easily
Plug 'preservim/nerdcommenter'
-- Handlebars integration
Plug 'mustache/vim-mustache-handlebars'
-- Search in the current window
Plug 'ggandor/leap.nvim'

Plug.ends()

-- NERDTree
vim.cmd('let NERDTreeShowHidden = 1')
vim.cmd([[autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif]])

-- localvimrc
vim.cmd('let g:localvimrc_persistent = 1')

-- Blamer
vim.cmd('let g:blamer_enabled = 1')
vim.cmd('let g:blamer_delay = 500')

-- CoC
vim.cmd('let g:coc_global_extensions = ['..
  [['coc-ember',]]..
  [['coc-json',]]..
  [['coc-snippets',]]..
  [['coc-tsserver',]]..
  [['@yaegassy/coc-volar']]..
']')

-- Leap
require('leap').set_default_keymaps()
