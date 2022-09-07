local fn = vim.fn
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(packer_install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_path})
end

--vim.cmd("let g:coq_settings = { 'auto_start': 'shut-up' }")

local plugins = require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  -- Per-project config files
  use {
    'MunifTanjim/exrc.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
    },
  }
  -- Startup
  use 'glepnir/dashboard-nvim'
  -- Treesitter for syntax highlighting
  use {'nvim-treesitter/nvim-treesitter', { run = vim.fn[':TSUpdate'] }}
  -- LSP
  use {
    'williamboman/nvim-lsp-installer',
    -- Completion
    --{'ms-jpq/coq_nvim', { branch = 'coq' }},
    --{'ms-jpq/coq.artifacts', { branch = 'artifacts' }},
    --{'ms-jpq/coq.thirdparty', { branch = '3p' }},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-cmdline'},
    {'hrsh7th/nvim-cmp'},
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  -- Color scheme
  use 'srcery-colors/srcery-vim'
  use 'ellisonleao/gruvbox.nvim'
  -- Sessions
  use 'rmagatti/auto-session'
  -- Filesystem tree
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    }
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
  use 'w0rp/ale'
  -- Fuzzy finder
  use {'junegunn/fzf', { run = vim.fn['fzf#install'] }}
  use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    }
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
  use 'APZelos/blamer.nvim'
  -- Symbols and tags in a sidebar
  use 'liuchengxu/vista.vim'
  -- Comment easily
  use 'preservim/nerdcommenter'
  -- Handlebars integration
  use 'mustache/vim-mustache-handlebars'
  -- Search in the current window
  use 'ggandor/leap.nvim'
  -- Indent lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Bracket colorization
  use 'junegunn/rainbow_parentheses.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Local config files
require('exrc').setup({
  files = {
    '.vimrc',
    '.lvimrc',
    '.nvimrc',
    '.exrc',
    '.nvimrc.lua',
    '.exrc.lua',
  }
})

local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
       require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    --{ name = 'vsnip' }, -- For vsnip users.
     { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})


-- Configure LSP servers
require("nvim-lsp-installer").setup {
  automatic_installation = true,
}
local lspconfig = require("lspconfig")
--local coq = require("coq")
--local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Here go the server setups
lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})
local eslint_config = require("lspconfig.server_configurations.eslint")
lspconfig.eslint.setup({
  capabilities = capabilities,
  cmd = { "yarn", "exec", unpack(eslint_config.default_config.cmd) }
})
lspconfig.volar.setup({
  capabilities = capabilities,
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
})
lspconfig.ember.setup({
  capabilities = capabilities,
})
lspconfig.cssls.setup({
  capabilities = capabilities,
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
})
lspconfig.html.setup({
  capabilities = capabilities,
})
lspconfig.stylelint_lsp.setup({
  capabilities = capabilities,
})
lspconfig.jsonls.setup({
  capabilities = capabilities,
})

-- ALE Linting
vim.cmd('let g:ale_fix_on_save = 1')

-- Dashboard
vim.cmd("let g:dashboard_default_executive='fzf'")
local dashboard = require('dashboard')
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

-- Session
require('auto-session').setup {
  auto_save_enabled = true,
  auto_restore_enabled = false
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "javascript", "typescript", "json", "css", "scss", "vue", "lua" },
}

-- Telescope
local telescope = require('telescope')
telescope.load_extension('fzf')

-- File tree
require("neo-tree").setup({
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      visible = true,
    },
    follow_current_file = true,
    use_libuv_file_watcher = true,
  }
})

-- Blamer
vim.cmd('let g:blamer_enabled = 1')
vim.cmd('let g:blamer_delay = 500')

-- Leap
require('leap').set_default_keymaps()

-- Indentation
require('indent_blankline').setup {
  show_current_context = true,
  show_current_context_start = true
}

return plugins
