local fn = vim.fn
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(packer_install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_path})
end

vim.cmd("let g:coq_settings = { 'auto_start': 'shut-up' }")

local plugins = require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  -- Startup
  use {
    'glepnir/dashboard-nvim',
    config = function()
      require'plugins.dashboard'
    end
  }
  -- Treesitter for syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function()
      require'plugins.treesitter'
    end
  }
  -- LSP
  use {
    {
      'williamboman/mason.nvim',
      config = function()
        require'mason'.setup()
      end
    },
    {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require'mason-lspconfig'.setup{
          ensure_installed = {
            'eslint-lsp',
            'lua-language-server',
            'css-lsp',
            'html-lsp',
            'json-lsp',
            'eslint_d',
            'typescript-language-server',
            'vue-language-server',
          },
          automatic_installation = true,
        }
      end
    },
    'neovim/nvim-lspconfig'
  }
  -- Completion
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    config = function()
      require'plugins.lsp'
    end,
  }
  use {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts'
  }
  use {
    'ms-jpq/coq.thirdparty',
    branch = '3p'
  }
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'romgrk/barbar.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  -- Color scheme
  use 'ellisonleao/gruvbox.nvim'
  -- Scroll
  use  {
    'karb94/neoscroll.nvim',
    config = function ()
      require'neoscroll'.setup()
    end
  }
  -- Sessions
  use {
    'rmagatti/auto-session',
    config = function()
      require'auto-session'.setup{
        auto_save_enabled = true,
        auto_restore_enabled = false
      }
    end
  }
  -- Filesystem tree
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require'plugins.neotree'
    end
  }
  -- Javascript integration
  use 'pangloss/vim-javascript'
  -- Vue syntax highlight
  use 'posva/vim-vue'
  -- Git plugin
  use 'tpope/vim-fugitive'
  -- Suggestions and completion
  -- Git marks in the gutter
  --use 'airblade/vim-gitgutter'
  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release', -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    config = function()
      require('gitsigns').setup()
    end
  }
  -- Git diff
  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  -- Statusbar
  --use 'vim-airline/vim-airline'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require'lualine'.setup{
        options = {
          theme = 'gruvbox'
        }
      }
    end
  }
  -- Typescript integration
  use 'leafgarland/typescript-vim'
  -- Editorconfig integration
  use 'editorconfig/editorconfig-vim'
  -- LSP marks in the gutter
  use {
    'dense-analysis/ale',
    config = 'vim.cmd("let g:ale_fix_on_save = 1")',
  }
  -- Per-project config files
  use {
    'MunifTanjim/exrc.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require'exrc'.setup{
        files = {
          '.vimrc',
          '.lvimrc',
          '.nvimrc',
          '.exrc',
          '.nvimrc.lua',
          '.exrc.lua',
        }
      }
    end
  }
  -- Fuzzy finder
  --use {'junegunn/fzf', { run = vim.fn['fzf#install'] }}
  --use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      require'telescope'.load_extension('fzf')
    end
  }
  use {'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  -- Show css colors inline
  use 'ap/vim-css-color'
  -- Underlines the current word and its appearances
  use 'itchyny/vim-cursorword'
  -- Change easily the surrounding characters
  use 'tpope/vim-surround'
  -- Autoclosing brackets
  use 'jiangmiao/auto-pairs'
  -- For writers
  use 'preservim/vim-pencil'
  -- Make multiline changes
  use 'mg979/vim-visual-multi'
  -- Inline git blame
  use 'f-person/git-blame.nvim'
  -- Symbols and tags in a sidebar
  use 'liuchengxu/vista.vim'
  -- Comment easily
  use 'preservim/nerdcommenter'
  -- Handlebars integration
  use 'mustache/vim-mustache-handlebars'
  -- Search in the current window
  use {
    'ggandor/leap.nvim',
    config = function()
      require'leap'.set_default_keymaps()
    end
  }
  -- Indent lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require'indent_blankline'.setup{
        show_current_context = true,
        show_current_context_start = true
      }
    end
  }
  -- Bracket colorization
  use 'junegunn/rainbow_parentheses.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

return plugins
