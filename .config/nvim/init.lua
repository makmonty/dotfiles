local constants = require('constants')

vim.cmd('set number')
vim.cmd('set relativenumber')
vim.cmd('set mouse=a')
vim.cmd('set termguicolors')
vim.cmd('set clipboard=unnamedplus')
vim.cmd('set laststatus=3')
vim.cmd('set updatetime=100')
-- Folds
vim.cmd('set foldmethod=expr') -- Treesitter folding
vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
vim.cmd('set foldlevelstart=99')

vim.g.mapleader = constants.leader

require('plugins')
require('mappings')
--require('commands')
-- Replaced by barbar.nvim
require('tabline')

vim.o.sessionoptions='blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
vim.diagnostic.config {
  virtual_text = false
}
