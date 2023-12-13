local constants = require('constants')

vim.cmd('set number')
vim.cmd('set relativenumber')
vim.cmd('set mouse=a')
vim.cmd('set termguicolors')
vim.cmd('set clipboard=unnamedplus')
vim.cmd('set laststatus=3')
vim.cmd('set updatetime=100')
vim.cmd('set ignorecase')
vim.cmd('set smartcase')
-- Folds
vim.cmd('set foldmethod=expr') -- Treesitter folding
vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
vim.cmd('set foldlevelstart=99')

vim.g.mapleader = constants.leader
vim.wo.signcolumn = 'yes'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--vim.cmd("let g:coq_settings = { 'auto_start': 'shut-up' }")

require('lazy').setup('plugins')
require('colorscheme')

require('mappings')
--require('commands')
-- Replaced by barbar.nvim
-- require('tabline')

vim.o.sessionoptions='blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
vim.diagnostic.config {
  virtual_text = false
}
