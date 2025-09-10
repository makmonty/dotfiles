return {
  -- Git plugin
  { 'tpope/vim-fugitive' },
  -- Suggestions and completion
  -- Git marks, actions and blame
  {
    'lewis6991/gitsigns.nvim',
    tag = 'release', -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    config = function()
      require('gitsigns').setup{
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 500,
        },
      }
    end
  },
  -- Git diff
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim'
  },
}
