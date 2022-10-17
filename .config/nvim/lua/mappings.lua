local map = require('helpers.map')

function ToggleNERDTree()
    --if expand('%:p') == '' || exists("g:NERDTree") && g:NERDTree.IsOpen() then
  vim.cmd('NERDTreeToggleVCS')
    --else
  --vim.cmd('NERDTreeFind')
    --end
end


vim.g.mapleader = ','

--map('n', '<C-f>', ':BLines<CR>')
--map('n', '<C-f>', ':Telescope current_buffer_fuzzy_find theme=dropdown<CR>')
map('n', '<C-f>', ':FzfLua lgrep_curbuf<CR>')
--map('n', '<C-g>', ':RG<CR>')
--map('n', '<C-g>', ':Telescope live_grep<CR>')
map('n', '<C-g>', ':FzfLua live_grep_resume<CR>')
--map('n', '<C-p>', 'isdirectory(".git") ? ":GFiles<CR>" : ":Files<CR>"', { expr = true })
--map('n', '<C-p>', ':Telescope find_files theme=dropdown<CR>')
map('n', '<C-p>', ':FzfLua files<CR>')
--map('n', '<Tab>', '<Cmd>lua ToggleNERDTree()<CR>')
map('n', '<leader>b', ':Telescope buffers theme=ivy<CR>')
map('n', '<Tab>', ':NeoTreeRevealToggle<CR>')
map('n', '<leader><Left>', '<C-w><Left>')
map('n', '<leader><Right>', '<C-w><Right>')
map('n', '<leader><Up>', '<C-w><Up>')
map('n', '<leader><Down>', '<C-w><Down>')
-- Using instead the barbar.nvim bindings
--map('n', 'th', ' :tabfirst<CR>')
--map('n', 'tk', ' :tabnext<CR>')
--map('n', 'tj', ' :tabprev<CR>')
--map('n', 'tl', ' :tablast<CR>')
--map('n', 'tt', ' :tabedit<Space>')
--map('n', 'tn', ' :tabnew<Space>')
--map('n', 'tm', ' :tabm<Space>')
--map('n', 'td', ' :tabclose<CR>')
map('n', 'th', ' :BufferGoto 1<CR>')
map('n', 'tk', ' :BufferNext<CR>')
map('n', 'tj', ' :BufferPrevious<CR>')
map('n', 'tl', ' :BufferLast<CR>')
map('n', 'td', ' :BufferClose<CR>')

-- Autoclosing pairs. Replaced by plugin
--map('i', '"', '""<left>')
--map('i', "'", "''<left>")
--map('i', '(', '()<left>')
--map('i', '[', '[]<left>')
--map('i', '{', '{}<left>')
--map('i', '{<CR>', '{<CR>}<ESC>O')
--map('i', '{;<CR>', '{<CR>};<ESC>O')
