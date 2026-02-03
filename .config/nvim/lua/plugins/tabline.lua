return {
  -- Tab management
  {
    'nanozuki/tabby.nvim',
    config = function()
      require('tabby.tabline').use_preset('tab_only', {
        nerdfont = true,
      })
    end,
  },
  -- {
  --   'romgrk/barbar.nvim',
  --   dependencies = 'nvim-tree/nvim-web-devicons',
  -- },
}
