return {
  -- Filesystem tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require'neo-tree'.setup{
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            visible = true,
          },
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        }
      }
    end
  },
}
