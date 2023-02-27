local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--vim.cmd("let g:coq_settings = { 'auto_start': 'shut-up' }")

require('lazy').setup({
  -- Startup
  {
    'glepnir/dashboard-nvim',
    config = function()
      require'plugins.dashboard'
    end
  },
  -- Treesitter for syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function()
      require'plugins.treesitter'
    end
  },
  -- LSP
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
          'eslint',
          'lua_ls',
          'cssls',
          'html',
          'jsonls',
          --'eslint_d',
          'tsserver',
          'volar',
        },
        automatic_installation = true,
      }
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      --require'plugins.lsp'
    end,
  },
  -- Null LSP
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local nullls = require('null-ls')
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      nullls.setup{
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.format({
                      bufnr = bufnr,
                      filter = function(cli)
                        return cli.name == "null-ls"
                      end
                    })
                end,
            })
          end
        end,
        sources = {
          nullls.builtins.code_actions.eslint_d,
          nullls.builtins.formatting.eslint_d,
        }
      }
    end
  },
  -- Completion
  --{
    --'ms-jpq/coq_nvim',
    --branch = 'coq',
    --config = function()
      --require'plugins.lsp'
    --end,
  --}
  --{
    --'ms-jpq/coq.artifacts',
    --branch = 'artifacts'
  --}
  --{
    --'ms-jpq/coq.thirdparty',
    --branch = '3p'
  --}
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require'plugins.cmp'
    end
  },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },

  {
    'folke/trouble.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
  },
  {
    'romgrk/barbar.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
  },
  -- Color scheme
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require'colorscheme'
    end
  },
  --{
    --'taphill/gruvbox.nvim',
    --dependencies = 'tjdevries/colorbuddy.nvim'
  --}
  {
    'srcery-colors/srcery-vim',
    name = 'srcery',
    lazy = false,
    priority = 1000,
  },
  -- Scroll
  {
    'karb94/neoscroll.nvim',
    config = function ()
      require'neoscroll'.setup()
    end
  },
  -- Sessions
  {
    'rmagatti/auto-session',
    config = function()
      require'auto-session'.setup{
        auto_save_enabled = true,
        auto_restore_enabled = false
      }
    end
  },
  -- Filesystem tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require'plugins.neotree'
    end
  },
  -- Javascript integration
  { 'pangloss/vim-javascript' },
  -- Vue syntax highlight
  { 'posva/vim-vue' },
  -- Git plugin
  { 'tpope/vim-fugitive' },
  -- Suggestions and completion
  -- Git marks in the gutter
  --'airblade/vim-gitgutter'
  {
    'lewis6991/gitsigns.nvim',
    tag = 'release', -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    config = function()
      require('gitsigns').setup()
    end
  },
  -- Git diff
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim'
  },
  -- Statusbar
  --'vim-airline/vim-airline'
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require'lualine'.setup{
        options = {
          theme = 'gruvbox'
        }
      }
    end
  },
  -- Typescript integration
  { 'leafgarland/typescript-vim' },
  -- Editorconfig integration
  { 'editorconfig/editorconfig-vim' },
  -- Per-project config files
  {
    'MunifTanjim/exrc.nvim',
    dependencies = {
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
  },
  -- Fuzzy finder
  --{
  --  'junegunn/fzf',
  --  build = vim.fn['fzf#install']
  --},
  --{ 'junegunn/fzf.vim' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    config = function()
      local telescope = require'telescope'
      telescope.setup{}
      telescope.load_extension('fzf')
    end
  },
  --{'ibhagwan/fzf-lua',
  --  -- optional for icon support
  --  dependencies = {'kyazdani42/nvim-web-devicons'}
  --},
  -- Show css colors inline
  { 'ap/vim-css-color' },
  -- Underlines the current word and its appearances
  { 'itchyny/vim-cursorword' },
  -- Change easily the surrounding characters
  { 'tpope/vim-surround' },
  -- Autoclosing brackets
  { 'jiangmiao/auto-pairs' },
  -- For writers
  { 'preservim/vim-pencil' },
  -- Make multiline changes
  { 'mg979/vim-visual-multi' },
  -- Inline git blame
  { 'f-person/git-blame.nvim' },
  -- Symbols and tags in a sidebar
  { 'liuchengxu/vista.vim' },
  -- Comment easily
  --{ 'preservim/nerdcommenter' },
  {
    'numToStr/Comment.nvim',
    config = function()
      require'Comment'.setup()
    end
  },
  -- Handlebars integration
  { 'mustache/vim-mustache-handlebars' },
  -- Search in the current window
  {
    'ggandor/leap.nvim',
    config = function()
      require'leap'.set_default_keymaps()
    end
  },
  -- Indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require'indent_blankline'.setup{
        show_current_context = true,
        show_current_context_start = true
      }
    end
  },
  -- Bracket colorization
  { 'junegunn/rainbow_parentheses.vim' },
  {
    'folke/which-key.nvim',
    config = function()
      require'which-key'.setup{}
    end
  }
})
