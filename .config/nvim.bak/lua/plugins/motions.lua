return {
  -- Search in the current window
  {
    'ggandor/leap.nvim',
    config = function()
      require'leap'.set_default_keymaps()
    end
  },
}
