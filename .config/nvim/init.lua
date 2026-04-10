local constants = require("constants")

vim.cmd("set number")
vim.cmd("set relativenumber")
--vim.cmd("set mouse=a")
vim.cmd("set termguicolors")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set laststatus=3")
vim.cmd("set updatetime=100")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
-- Folds
vim.cmd("set foldmethod=expr") -- Treesitter folding
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
vim.cmd("set foldlevelstart=99")

vim.g.mapleader = constants.leader
vim.wo.signcolumn = "yes"

--vim.cmd("let g:coq_settings = { 'auto_start': 'shut-up' }")

require("packages")
require("colorscheme")
require("mappings")
--require('commands')
-- Replaced by barbar.nvim
-- require('tabline')

-- require("vim._core.ui2").enable()

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.diagnostic.config({
  virtual_text = false,
})

vim.opt.complete = ".,t,o"
vim.opt.completeopt = "fuzzy,menu,menuone,noinsert,popup,preview"
vim.opt.pumborder = "rounded"
vim.opt.pummaxwidth = 40
vim.opt.pumblend = 20
vim.opt.wildmode = "noselect:lastused,full"
vim.opt.wildoptions = "pum"

local lspAutocmdGroup = vim.api.nvim_create_augroup("my.lsp", {})
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     if vim.bo.buftype == "nofile" then
--       vim.opt.autocomplete = false
--       return
--     end
--     vim.opt.autocomplete = true
--   end,
-- })
-- autocmd CmdlineChanged [:\/\?] call wildtrigger()
vim.api.nvim_create_autocmd("CmdlineChanged", {
  group = lspAutocmdGroup,
  pattern = { "[:/?]" },
  callback = function()
    vim.fn.wildtrigger()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = lspAutocmdGroup,
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    if client:supports_method("textDocument/completion") then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      local chars = {}
      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end
      client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
        autotrigger = true,
        -- Optional formating of items
        convert = function(item)
          -- Remove leading misc chars for abbr name,
          -- and cap field to 25 chars
          --local abbr = item.label
          --abbr = abbr:match("[%w_.]+.*") or abbr
          --abbr = #abbr > 25 and abbr:sub(1, 24) .. "…" or abbr
          --
          -- Remove return value
          --local menu = ""

          -- Only show abbr name, remove leading misc chars (bullets etc.),
          -- and cap field to 15 chars
          local abbr = item.label
          abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
          abbr = abbr:match("[%w_.]+.*") or abbr
          abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr

          -- Cap return value field to 15 chars
          local menu = item.detail or ""
          menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu

          return { abbr = abbr, menu = menu }
        end,
      })
    end
  end,
})
