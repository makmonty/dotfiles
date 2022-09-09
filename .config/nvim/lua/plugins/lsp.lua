local lspconfig = require("lspconfig")
local coq = require("coq")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Here go the server setups
lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}))
local eslint_config = require("lspconfig.server_configurations.eslint")
lspconfig.eslint.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
})
lspconfig.volar.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
})
lspconfig.ember.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
})
lspconfig.cssls.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
})
lspconfig.html.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
})
lspconfig.stylelint_lsp.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
})
lspconfig.jsonls.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
})
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
})

