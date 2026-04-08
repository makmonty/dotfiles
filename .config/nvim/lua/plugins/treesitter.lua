return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "javascript",
          "typescript",
          "json",
          "css",
          "scss",
          "html",
          "vue",
          "lua",
          "markdown",
          "markdown_inline",
          "hyprlang",
        },
      })
    end,
  },
}
