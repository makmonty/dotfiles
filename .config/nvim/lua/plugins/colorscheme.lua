return {
  -- Color scheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup{
        flavour = 'mocha'
      }
      require('colorscheme')
    end
  },
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
  {
    'srcery-colors/srcery-vim',
    name = 'srcery',
    lazy = false,
    priority = 1000,
  },
}
