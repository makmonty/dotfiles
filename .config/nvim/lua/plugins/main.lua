return {
  -- Startup time
  -- {
  --   url = "https://git.sr.ht/~henriquehbr/nvim-startup.lua",
  --   config = function()
  --     require("nvim-startup").setup()
  --   end,
  -- },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
  },
  -- Scroll
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
  },
  -- Sessions
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        auto_save_enabled = true,
        auto_restore_enabled = false,
      })
    end,
  },
  -- Per-project config files
  {
    "MunifTanjim/exrc.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("exrc").setup({
        files = {
          ".vimrc",
          ".lvimrc",
          ".nvimrc",
          ".exrc",
          ".nvimrc.lua",
          ".exrc.lua",
        },
      })
    end,
  },
  -- Find and replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },
}
