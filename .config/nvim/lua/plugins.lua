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
      vim.cmd('let g:dashboard_default_executive="fzf"')
      local dashboard = require'dashboard'
      dashboard.custom_center = {
        {
          icon = '  ',
          desc = 'Restore last session                    ',
          shortcut = 'SPC s l',
          action ='RestoreSession'
        },
        {
          icon = '  ',
          desc = 'Recent sessions                         ',
          action =  'Autosession search',
          shortcut = 'SPC f h'
        },
        {
          icon = '  ',
          desc = 'Find File                               ',
          action = 'Telescope find_files find_command=rg,--hidden,--files',
          shortcut = 'SPC f f'
        },
        {
          icon = '  ',
          desc ='File Browser                            ',
          action =  'Telescope file_browser',
          shortcut = 'SPC f b'
        },
        {
          icon = '  ',
          desc = 'Find word                               ',
          action = 'Telescope live_grep',
          shortcut = 'SPC f w'
        },
      }
    end
  }
  -- Treesitter for syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = vim.fn[':TSUpdate'],
    config = function()
      require'nvim-treesitter.configs'.setup{
        -- A list of parser names, or "all"
        ensure_installed = { "javascript", "typescript", "json", "css", "scss", "vue", "lua" },
      }
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
      local lspconfig = require("lspconfig")
      local coq = require("coq")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- Here go the server setups
      lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      }))
      local eslint_config = require("lspconfig.server_configurations.eslint")
      lspconfig.eslint.setup(coq.lsp_ensure_capabilities{
        capabilities = capabilities,
      })
      lspconfig.volar.setup(coq.lsp_ensure_capabilities{
        capabilities = capabilities,
      })
      lspconfig.ember.setup(coq.lsp_ensure_capabilities{
        capabilities = capabilities,
      })
      lspconfig.cssls.setup(coq.lsp_ensure_capabilities{
        capabilities = capabilities,
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
      })
      lspconfig.html.setup(coq.lsp_ensure_capabilities{
        capabilities = capabilities,
      })
      lspconfig.stylelint_lsp.setup(coq.lsp_ensure_capabilities{
        capabilities = capabilities,
      })
      lspconfig.jsonls.setup(coq.lsp_ensure_capabilities{
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup(coq.lsp_ensure_capabilities{
        capabilities = capabilities,
      })
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
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  -- Color scheme
  use 'srcery-colors/srcery-vim'
  use 'ellisonleao/gruvbox.nvim'
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
      require'neo-tree'.setup{
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            visible = true,
          },
          follow_current_file = true,
          use_libuv_file_watcher = true,
        }
      }
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
  use 'airblade/vim-gitgutter'
  -- Statusbar
  use 'vim-airline/vim-airline'
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
  use {'junegunn/fzf', { run = vim.fn['fzf#install'] }}
  use 'junegunn/fzf.vim'
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
