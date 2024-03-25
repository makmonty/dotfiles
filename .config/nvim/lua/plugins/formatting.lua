return {
  -- {
  --   'stevearc/conform.nvim',
  --   event = { "BufWritePre" },
  --   cmd = { "ConformInfo" },
  --   keys = {
  --     {
  --       -- Customize or remove this keymap to your liking
  --       "<space>f",
  --       function()
  --         require("conform").format()
  --       end,
  --       mode = "",
  --       desc = "Format buffer",
  --     },
  --   },
  --   -- Everything in opts will be passed to setup()
  --   opts = {
  --     -- Define your formatters
  --     formatters_by_ft = {
  --       lua = { "stylua" },
  --       python = { "isort", "black" },
  --       javascript = { { "eslint", "prettierd", "prettier" } },
  --       typescript = { { "eslint", "prettierd", "prettier" } },
  --     },
  --     -- Set up format-on-save
  --     format_on_save = { timeout_ms = 1000, lsp_fallback = true },
  --     -- Customize formatters
  --     formatters = {
  --       shfmt = {
  --         prepend_args = { "-i", "2" },
  --       },
  --     },
  --   },
  --   log_level = vim.log.levels.TRACE,
  --   -- init = function()
  --   --   -- If you want the formatexpr, here is the place to set it
  --   --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  --   -- end,
  -- }
  {
    "mhartington/formatter.nvim",

    config = function()
      -- Utilities for creating configurations
      local util = require("formatter.util")

      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      local defaults = require("formatter.defaults")

      local vueformatter = util.withl(defaults.eslint_d, "vue")
      require("formatter").setup({
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- -- You can also define your own configuration
            -- function()
            --   -- Supports conditional formatting
            --   if util.get_current_buffer_file_name() == "special.lua" then
            --     return nil
            --   end
            --
            --   -- Full specification of configurations is down below and in Vim help
            --   -- files
            --   return {
            --     exe = "stylua",
            --     args = {
            --       "--search-parent-directories",
            --       "--stdin-filepath",
            --       util.escape_path(util.get_current_buffer_file_path()),
            --       "--",
            --       "-",
            --     },
            --     stdin = true,
            --   }
            -- end,
          },
          javascript = {
            require("formatter.filetypes.javascript").eslint_d,
          },
          javascriptreact = {
            require("formatter.filetypes.javascriptreact").eslint_d,
          },
          typescript = {
            require("formatter.filetypes.typescript").eslint_d,
          },
          typescriptreact = {
            require("formatter.filetypes.typescriptreact").eslint_d,
          },
          vue = {
            -- vueformatter,
            require("formatter.filetypes.javascript").eslint_d,
            -- require("formatter.defaults.eslint_d"),
            -- require("formatter.filetypes.vue").prettier,
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })

      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd
      augroup("__formatter__", { clear = true })
      autocmd("BufWritePost", {
        group = "__formatter__",
        command = ":FormatWrite",
      })
    end,
  },
}
