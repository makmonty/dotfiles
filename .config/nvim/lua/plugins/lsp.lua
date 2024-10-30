return {
  { "neovim/nvim-lspconfig" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local mason_registry = require("mason-registry")
      local util = lspconfig.util
      --local coq = require("coq")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Mappings. https://github.com/neovim/nvim-lspconfig
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        --client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentFormattingProvider = true
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>", bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>D", ":Telescope lsp_type_definitions<CR>", bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", bufopts)

        --autocmds
        -- vim.cmd('autocmd CursorHold * silent! lua vim.diagnostic.open_float({focus = false, source = true})')
        --vim.cmd('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')
        local diagnosticGroup = vim.api.nvim_create_augroup("Line diagnostics", { clear = true })
        -- Commenting out to debug the config
        -- vim.api.nvim_create_autocmd("CursorHold", {
        --   command = "Lspsaga show_cursor_diagnostics ++unfocus",
        --   group = diagnosticGroup,
        -- })

        -- vim.cmd('autocmd CursorHold * silent! Lspsaga show_cursor_diagnostics')
      end

      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }

      local setupLsp = function(lsp, options)
        --lsp.setup(coq.lsp_ensure_capabilities(options))
        lsp.setup(options)
      end

      -- Here go the server setups

      setupLsp(lspconfig.lua_ls, {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
        on_attach = on_attach,
        flags = lsp_flags,
      })
      setupLsp(lspconfig.eslint, {
        capabilities = capabilities,
        flags = lsp_flags,
        on_attach = on_attach,
        -- on_attach = function(client, bufnr)
        --   on_attach(client, bufnr)
        --   if client.server_capabilities.documentFormattingProvider then
        --     local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --       pattern = "*",
        --       callback = function()
        --         vim.lsp.buf.format()
        --       end,
        --       group = au_lsp,
        --     })
        --   end
        -- end,
        -- cmd = { 'eslint_d', "--stdio" },
        --settings = {
        --codeActionOnSave = {
        --enabled = true,
        --mode = 'all',
        --},
        --},
      })
      setupLsp(lspconfig.volar, {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        filetypes = { "vue" },
      })
      setupLsp(lspconfig.cssls, {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
      })
      setupLsp(lspconfig.html, {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })
      --setupLsp(lspconfig.stylelint_lsp, {
      --capabilities = capabilities,
      --on_attach = on_attach,
      --flags = lsp_flags,
      --})
      setupLsp(lspconfig.jsonls, {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server"
      setupLsp(lspconfig.ts_ls, {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "javascript", "typescript", "vue" },
            },
          },
        },
      })
      setupLsp(lspconfig.openscad_lsp, {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })
      setupLsp(lspconfig.clangd, {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = true,
          enable_in_insert = true,
          sign = true,
          sign_priority = 40,
          virtual_text = false,
        },
      })
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
