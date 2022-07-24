require('plugins')
require('mappings')
require('commands')
require('tabline')

vim.cmd('set clipboard=unnamedplus')
vim.cmd('colorscheme srcery')
vim.cmd('set number')
vim.cmd('set mouse=a')
vim.o.sessionoptions='blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

