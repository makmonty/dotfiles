return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local nullls = require('null-ls')
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      nullls.setup{
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            local format = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(cli)
                  return cli.name == "null-ls"
                end
              })
            end,

            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.keymap.set('n', '<space>f', format, bufopts)
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = format
            })
          end
        end,
        sources = {
          nullls.builtins.code_actions.gitsigns.with({
            -- config = {
            --   filter_actions = function(title)
            --     return title:lower():match("blame") == nil -- filter out blame actions
            --   end,
            -- },
          }),
          nullls.builtins.code_actions.eslint_d,
          nullls.builtins.formatting.eslint_d,
          -- nullls.builtins.formatting.prettierd.with({
          --   condition = function(utils)
          --     return utils.root_has_file({
          --       ".prettierrc",
          --       ".prettierrc.json",
          --       ".prettierrc.yml",
          --       ".prettierrc.yaml",
          --       ".prettierrc.json5",
          --       ".prettierrc.js",
          --       ".prettierrc.cjs",
          --       ".prettierrc.toml",
          --       "prettier.config.js",
          --       "prettier.config.cjs",
          --     })
          --   end
          -- }),
        }
      }
    end
  },
}
