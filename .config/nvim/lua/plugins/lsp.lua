local lspconfig = require("lspconfig")
local coq = require("coq")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Mappings. https://github.com/neovim/nvim-lspconfig
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  --client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentFormattingProvider = true
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

  --autocmds
  vim.cmd('autocmd CursorHold * silent! lua vim.diagnostic.open_float({focus = false})')
  --vim.cmd('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Here go the server setups
lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  },
  on_attach = on_attach,
  flags = lsp_flags,
}))

lspconfig.eslint.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    --if client.server_capabilities.documentFormattingProvider then
      --local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
      --vim.api.nvim_create_autocmd("BufWritePre", {
        --pattern = "*",
        --callback = function()
          --vim.lsp.buf.format()
        --end,
        --group = au_lsp,
      --})
    --end
  end,
  flags = lsp_flags,
  --cmd = { 'eslint_d', "--stdio" },
  --settings = {
    --codeActionOnSave = {
      --enabled = true,
      --mode = 'all',
    --},
  --},
})
lspconfig.volar.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = {'typescript', 'javascript', 'vue'},
})
lspconfig.ember.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
})
lspconfig.cssls.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
})
lspconfig.html.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
})
lspconfig.stylelint_lsp.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
})
lspconfig.jsonls.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
})
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
})

