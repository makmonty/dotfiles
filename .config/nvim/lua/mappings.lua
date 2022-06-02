local map = require('helpers.map')

function ToggleNERDTree()
    --if expand('%:p') == '' || exists("g:NERDTree") && g:NERDTree.IsOpen() then
  vim.cmd('NERDTreeToggleVCS')
    --else
  --vim.cmd('NERDTreeFind')
    --end
end


vim.g.mapleader = ','

map('n', '<C-f>', ':BLines<CR>')
map('n', '<C-g>', ':RG<CR>')
map('n', '<C-p>', 'isdirectory(".git") ? ":GFiles<CR>" : ":Files<CR>"', { expr = true })
--map('n', '<Tab>', '<Cmd>lua ToggleNERDTree()<CR>')
map('n', '<Tab>', ':NvimTreeFindFileToggle<CR>')
map('n', '<leader><Left>', '<C-w><Left>')
map('n', '<leader><Right>', '<C-w><Right>')
map('n', '<leader><Up>', '<C-w><Up>')
map('n', '<leader><Down>', '<C-w><Down>')
map('n', 'th', ' :tabfirst<CR>')
map('n', 'tk', ' :tabnext<CR>')
map('n', 'tj', ' :tabprev<CR>')
map('n', 'tl', ' :tablast<CR>')
map('n', 'tt', ' :tabedit<Space>')
map('n', 'tn', ' :tabnew<Space>')
map('n', 'tm', ' :tabm<Space>')
map('n', 'td', ' :tabclose<CR>')
