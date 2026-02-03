return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local ts = require("nvim-treesitter")
      ts.install({
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
      })
    end,
  },
}
