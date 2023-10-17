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
