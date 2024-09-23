return {
  {
    'williamboman/mason.nvim',
    config = function()
      require'mason'.setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require'mason-lspconfig'.setup{
        ensure_installed = {
          'eslint',
          'lua_ls',
          'cssls',
          'html',
          'jsonls',
          --'eslint_d',
          'ts_ls',
          'volar',
        },
        automatic_installation = true,
      }
    end
  },
}
