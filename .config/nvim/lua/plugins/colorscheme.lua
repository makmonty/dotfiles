local copy_table = require("helpers.table").copy_table

return {
  "Mofiqul/dracula.nvim",
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
  -- {
  --   "AlphaTechnolog/pywal.nvim",
  --   name = "pywal",
  --   config = function()
  --     require("pywal").setup()
  --   end,
  -- },
  -- Color scheme
  -- {
  --   'jzelinskie/monokai-soda.vim',
  --   dependencies = {
  --     'tjdevries/colorbuddy.vim'
  --   }
  -- },
  -- {
  --   'tanvirtin/monokai.nvim',
  --   config = function()
  --     local monokai = require('monokai')
  --     local soda = copy_table(monokai.soda)
  --     soda.base0 = "#191919"
  --     monokai.setup({
  --       palette = soda,
  --       custom_hlgroups = {
  --         Normal = {
  --           bg = soda.base0
  --         }
  --       }
  --     })
  --   end
  -- },
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   config = function()
  --     require('catppuccin').setup{
  --       flavour = 'mocha'
  --     }
  --     require('colorscheme')
  --   end
  -- },
  -- {
  --   'ellisonleao/gruvbox.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require'colorscheme'
  --   end
  -- },
  --{
  --'taphill/gruvbox.nvim',
  --dependencies = 'tjdevries/colorbuddy.nvim'
  --}
  -- {
  --   "srcery-colors/srcery-vim",
  --   name = "srcery",
  --   lazy = false,
  --   priority = 1000,
  -- },
}
