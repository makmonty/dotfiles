return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function()
      require'nvim-treesitter.configs'.setup{
        -- A list of parser names, or "all"
        ensure_installed = { "javascript", "typescript", "json", "css", "scss", "html", "vue", "lua", "markdown", "markdown_inline" },
        highlight = {
          enable = true,
        }
      }
      vim.filetype.add({
        pattern = {[".*/hyprland%.conf"] = "hyprlang"}
      })
    end
  },
}
