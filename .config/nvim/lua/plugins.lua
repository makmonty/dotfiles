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
  use 'glepnir/dashboard-nvim'
  -- Treesitter for syntax highlighting
  use {'nvim-treesitter/nvim-treesitter', { run = vim.fn[':TSUpdate'] }}
  -- LSP
  use {
    "williamboman/nvim-lsp-installer",
    -- Completion
    {'ms-jpq/coq_nvim', { branch = 'coq' }},
    {'ms-jpq/coq.artifacts', { branch = 'artifacts' }},
    {'ms-jpq/coq.thirdparty', { branch = '3p' }},
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("nvim-lsp-installer").setup {
          automatic_installation = true,
        }
        local lspconfig = require("lspconfig")
        local coq = require("coq")
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
        lspconfig.eslint.setup(coq.lsp_ensure_capabilities({
          cmd = { "yarn", "exec", unpack(eslint_config.default_config.cmd) }
        }))
        lspconfig.volar.setup(coq.lsp_ensure_capabilities({
          filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
        }))
        lspconfig.ember.setup(coq.lsp_ensure_capabilities({}))

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        lspconfig.cssls.setup(coq.lsp_ensure_capabilities({
          capabilities = capabilities,
          cmd = { "vscode-css-language-server", "--stdio" },
          filetypes = { "css", "scss", "less" },
        }))
      end
    }
  }
  -- Color scheme
  use 'srcery-colors/srcery-vim'
  use { "ellisonleao/gruvbox.nvim" }
  -- Filesystem tree
  --use 'preservim/nerdtree'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    --tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  -- Icons for NERDTree
  --use 'ryanoasis/vim-devicons'
  -- Git integration for NERDTree
  --use 'Xuyuanp/nerdtree-git-plugin'
  -- Colorize NERDTree
  --use 'tiagofumo/vim-nerdtree-syntax-highlight'
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
  -- Local vimrc
  use 'embear/vim-localvimrc'
  -- Fuzzy finder
  --use {'junegunn/fzf', { run = vim.fn['fzf#install'] }}
  --use 'junegunn/fzf.vim'
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

-- Dashboard
vim.cmd("let g:dashboard_default_executive='fzf'")

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "javascript", "typescript", "json", "css", "scss", "vue", "lua" },
}

-- Telescope
local telescope = require('telescope')
telescope.load_extension('fzf')
--telescope.setup{
  --defaults = {
    --theme = "ivy"
  --}
--}

-- NERDTree
--vim.cmd('let NERDTreeShowHidden = 1')
--vim.cmd([[autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif]])

-- NvimTree
require('nvim-tree').setup {}
-- Close when it's the last
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

-- localvimrc
vim.cmd('let g:localvimrc_persistent = 1')

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
