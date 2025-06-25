return {
  {
    'mason-org/mason.nvim',
    config = function()
      require'mason'.setup()
    end
  },
  {
    'mason-org/mason-lspconfig.nvim',
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
          'vue_ls',
        },
        automatic_installation = true,
      }
    end
  },
}
