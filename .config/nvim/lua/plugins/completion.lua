return {
  -- CoQ
  -- Completion
  --{
  --'ms-jpq/coq_nvim',
  --branch = 'coq',
  --config = function()
  --require'plugins.lsp'
  --end,
  --}
  --{
  --'ms-jpq/coq.artifacts',
  --branch = 'artifacts'
  --}
  --{
  --'ms-jpq/coq.thirdparty',
  --branch = '3p'
  --}
  --
  -- CMP
  -- { 'hrsh7th/cmp-nvim-lsp' },
  -- { 'hrsh7th/cmp-buffer' },
  -- { 'hrsh7th/cmp-path' },
  -- { 'hrsh7th/cmp-cmdline' },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   config = function()
  --     local cmp = require'cmp'
  --     cmp.setup{
  --       snippet = {
  --         expand = function(args)
  --           require'luasnip'.lsp_expand(args.body)
  --         end
  --       },
  --       window = {
  --         -- completion = cmp.config.window.bordered(),
  --         -- documentation = cmp.config.window.bordered(),
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --         ['<C-e>'] = cmp.mapping.abort(),
  --         ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --       }),
  --       sources = cmp.config.sources({
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip' },
  --       }, {
  --         { name = 'buffer' },
  --       })
  --     }
  --
  --     -- Set configuration for specific filetype.
  --     cmp.setup.filetype('gitcommit', {
  --       sources = cmp.config.sources({
  --         { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  --       }, {
  --         { name = 'buffer' },
  --       })
  --     })
  --
  --     -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  --     cmp.setup.cmdline({ '/', '?' }, {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = 'buffer' }
  --       }
  --     })
  --
  --     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --     cmp.setup.cmdline(':', {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = 'path' }
  --       }, {
  --         { name = 'cmdline' }
  --       })
  --     })
  --
  --     require'plugins.lsp'
  --   end
  -- },
  --
  -- Blink
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "v0.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = { preset = "enter" },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- optionally disable cmdline completions
        -- cmdline = {},
      },

      -- experimental signature help support
      signature = { enabled = true },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
  },
}
