return {
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<space>f",
        function()
          require("conform").format()
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "eslint_d", "eslint", "prettierd", "prettier" } },
        typescript = { { "eslint_d", "eslint", "prettierd", "prettier" } },
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 1000, lsp_fallback = true },
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
        -- eslint_d = {
        --   command = "eslint_d",
        --   args = { "--stdin", "--fix-to-stdout", "--stdin-filename", "$FILENAME" }
        -- }
      },
    },
    log_level = vim.log.levels.TRACE,
    -- init = function()
    --   -- If you want the formatexpr, here is the place to set it
    --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    -- end,
  }
}
