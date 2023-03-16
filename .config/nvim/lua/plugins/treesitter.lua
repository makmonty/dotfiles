require'nvim-treesitter.configs'.setup{
  -- A list of parser names, or "all"
  ensure_installed = { "javascript", "typescript", "json", "css", "scss", "html", "vue", "lua" },
  highlight = {
    enable = true,
  }
}
