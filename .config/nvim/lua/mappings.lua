local map = require("helpers.map")

map("i", "<C-S>", "<C-O>:w<CR>")
map("n", "<C-S>", ":w<CR>")
map("n", "<Leader>f", ":FzfLua grep_curbug<CR>")
--map('n', '<C-f>', ':FzfLua lgrep_curbuf<CR>')
map("n", "<Leader>g", ":FzfLua live_grep<CR>")
--map('n', '<C-g>', ':FzfLua live_grep_resume<CR>')
map("n", "<C-p>", ":FzfLua files<CR>")
map("n", "<Leader><Space>", ":FzfLua files<CR>")
--map('n', '<C-p>', ':FzfLua files<CR>')
map("n", "<Leader>b", ":FzfLua buffers<CR>")
map("n", "<Leader><Leader>", ":FzfLua buffers<CR>")
map("n", "<Leader>p", ":Telescope pickers<CR>")
map("n", "<Leader>r", ":FzfLua resume<CR>")
map("n", "<Leader>t", ":Trouble diagnostics toggle filter.buf=0<CR>")
map("n", "<Leader><Tab>", ":Neotree toggle<CR>")
map("n", "<Leader><Left>", "<C-w><Left>")
map("n", "<Leader><Right>", "<C-w><Right>")
map("n", "<Leader><Up>", "<C-w><Up>")
map("n", "<Leader><Down>", "<C-w><Down>")
-- Using instead the barbar.nvim bindings
map("n", "th", " :tabfirst<CR>")
map("n", "tj", " :tabprev<CR>")
map("n", "tk", " :tabnext<CR>")
map("n", "tl", " :tablast<CR>")
map("n", "tt", " :tabedit<Space>")
map("n", "tn", " :tabnew<Space>")
map("n", "tm", " :tabm<Space>")
map("n", "td", " :tabclose<CR>")
-- map('n', 'th', ' :BufferGoto 1<CR>')
-- map('n', 'tj', ' :BufferPrevious<CR>')
-- map('n', 'tk', ' :BufferNext<CR>')
-- map('n', 'tl', ' :BufferLast<CR>')
-- map('n', 'td', ' :BufferClose<CR>')
