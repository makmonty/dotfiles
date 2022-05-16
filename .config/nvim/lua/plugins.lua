local plugins = require('packer').startup(function(use)
	-- Color scheme
	use 'srcery-colors/srcery-vim'
	-- Filesystem tree
	use 'preservim/nerdtree'
	-- Icons for NERDTree
	use 'ryanoasis/vim-devicons'
	-- Git integration for NERDTree
	use 'Xuyuanp/nerdtree-git-plugin'
	-- Colorize NERDTree
	use 'tiagofumo/vim-nerdtree-syntax-highlight'
	-- Treesitter for syntax highlighting
	use {'nvim-treesitter/nvim-treesitter', { run = vim.fn[':TSUpdate'] }}
	-- Javascript integration
	use 'pangloss/vim-javascript'
	-- Vue syntax highlight
	use 'posva/vim-vue'
	-- Git plugin
	use 'tpope/vim-fugitive'
	-- Suggestions and completion
	use {'neoclide/coc.nvim', { branch = 'release' }}
	-- Git marks in the gutter
	use 'airblade/vim-gitgutter'
	-- Statusbar
	use 'vim-airline/vim-airline'
	-- Typescript integration
	use 'leafgarland/typescript-vim'
	-- Editorconfig integration
	use 'editorconfig/editorconfig-vim'
	-- Colorize parentheses
	use 'kien/rainbow_parentheses.vim'
	-- LSP marks in the gutter
	use 'w0rp/ale'
	-- Local vimrc
	use 'embear/vim-localvimrc'
	-- Fuzzy finder
	use {'junegunn/fzf', { run = vim.fn['fzf#install'] }}
	use 'junegunn/fzf.vim'
	--use 'nvim-lua/plenary.nvim'
	--use 'nvim-telescope/telescope.nvim'
	-- Show css colors inline
	use 'ap/vim-css-color'
	-- Underlines the current word and its appearances
	use 'itchyny/vim-cursorword'
	-- Change easily the surrounding characters
	use 'tpope/vim-surround'
	-- For writers
	use 'preservim/vim-pencil'
	-- Make multiline changes
	use 'mg979/vim-visual-multi'
	-- Inline git blame
	use 'APZelos/blamer.nvim'
	-- Symbols and tags in a sidebar
	use 'liuchengxu/vista.vim'
	-- Comment easily
	use 'preservim/nerdcommenter'
	-- Handlebars integration
	use 'mustache/vim-mustache-handlebars'
	-- Search in the current window
	use 'ggandor/leap.nvim'

end)

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

return plugins
