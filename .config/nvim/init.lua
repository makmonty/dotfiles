require('plugins')
require('mappings')
require('commands')
-- Replaced by barbar.nvim
--require('tabline')

vim.cmd('set clipboard=unnamedplus')
vim.cmd('colorscheme srcery')
vim.cmd('set number')
vim.cmd('set mouse=a')
vim.cmd('set laststatus=3')
vim.cmd('set updatetime=100')
vim.o.sessionoptions='blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

