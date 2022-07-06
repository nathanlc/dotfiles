-- Leader
vim.api.nvim_set_keymap('n', '<Space>', '', {noremap = true})
vim.g.mapleader = ' '

-- General
vim.api.nvim_set_keymap('n', 'z1', ':setlocal foldlevel=1<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'z2', ':setlocal foldlevel=2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'z3', ':setlocal foldlevel=3<CR>', {noremap = true})

-- Navigation
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true})

-- Command
-- vim.api.nvim_set_keymap('c', '<C-b>', '<Left>', {noremap = true})
-- vim.api.nvim_set_keymap('c', '<C-f>', '<Right>', {noremap = true})
-- vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', {noremap = true})
-- vim.api.nvim_set_keymap('c', '<C-e>', '<End>', {noremap = true})
-- vim.api.nvim_set_keymap('c', '<C-d>', '<Delete>', {noremap = true})

-- Buffers
-- vim.api.nvim_set_keymap('n', '<leader>bl', ':buffers<CR>:buffer', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bl', ':Telescope buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bd', ':bprevious<CR>:bdelete!#<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bD', ':bprevious<CR>:bdelete!#<CR><C-w>c', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>br', ':edit %<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bn', ':enew <CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>be', 'ggdG', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bs', [[<Cmd>lua require('buffer').scratch()<CR>]], {noremap = true, silent = true})

-- Files
vim.api.nvim_set_keymap('n', '<C-s>', ':write<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fl', ':Telescope find_files<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fL', [[<Cmd>lua require('commands').find_files()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fo', ':Telescope oldfiles<CR>', {noremap = true, silent = true})

-- Projects
vim.api.nvim_set_keymap('n', '<leader>pl', ':Telescope project display_type=full<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pb', [[<Cmd>lua require('telescope.builtin').buffers({only_cwd = true})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pa', ':A<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pc', ':Make<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pt', ':Dispatch<CR>', {noremap = true, silent = true})

-- Print info
vim.api.nvim_set_keymap('n', '<leader>Pp', ':pwd<CR>', {noremap = true, silent = true})

-- Windows
vim.api.nvim_set_keymap('n', '<leader>w', '<C-w>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wd', '<C-w>c', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>wS', ':leftabove split<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>wV', ':leftabove vsplit<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', {noremap = true})
-- vim.api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-N><C-w>h', {noremap = true})
-- vim.api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-N><C-w>j', {noremap = true})
-- vim.api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-N><C-w>k', {noremap = true})
-- vim.api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-N><C-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-h>', ':TmuxNavigateLeft<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-j>', ':TmuxNavigateDown<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-k>', ':TmuxNavigateUp<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-l>', ':TmuxNavigateRight<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-h>', ':TmuxNavigateLeft<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-j>', ':TmuxNavigateDown<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-k>', ':TmuxNavigateUp<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-l>', ':TmuxNavigateRight<CR>', {noremap = true, silent = true})

-- Search
vim.api.nvim_set_keymap('n', '<leader>sg', ':silent grep ', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>sG', ':Telescope live_grep<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ss', ':Telescope current_buffer_fuzzy_find<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sS', [[<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({default_text = vim.fn.expand('<cexpr>')})<CR>]], {noremap = true, silent = true})

-- Jump
vim.api.nvim_set_keymap('n', '<leader>j', ':Telescope lsp_document_symbols<CR>', {noremap = true, silent = true})

-- Tabs
vim.api.nvim_set_keymap('n', '<leader>Te', ':tabedit ', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>Tn', ':tabnew<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>T<', ':-tabmove<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>T>', ':+tabmove<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>To', ':tabonly<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Td', ':tabclose<CR>', {noremap = true, silent = true})

-- Toggle
vim.api.nvim_set_keymap('n', '<leader>ts', ':nohlsearch<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>tl', ':setlocal wrap!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>twh', ':set winfixheight!<CR>', {noremap = true, silent = true})

-- Terminal
vim.api.nvim_set_keymap('n', '<leader>"n', ':split term://bash<CR>:resize 18<CR>:setlocal winfixheight<CR>i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>"l', [[<Cmd>lua require('telescope.builtin').buffers({default_text = "term://"})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-N>', {noremap = true})
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-N>', {noremap = true})

-- Configuration
vim.api.nvim_set_keymap('n', '<leader>Cn', ':tabedit $HOME/.config/nvim/init.lua<CR>:lcd $HOME/.config/nvim<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Cd', ':tabedit $HOME/sandbox/mine/dotfiles<CR>:lcd $HOME/sandbox/mine/dotfiles<CR>', {noremap = true, silent = true})

-- Diagnostic
vim.api.nvim_set_keymap('n', '<leader>ed', '<Cmd>lua vim.diagnostic.open_float()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ep', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>en', '<Cmd>lua vim.diagnostic.goto_next()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>el', '<Cmd>lua vim.diagnostic.setloclist()<CR>', {noremap = true, silent = true})


-- Quickfix list
vim.api.nvim_set_keymap('n', '<leader>qo', ':copen<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qc', ':cclose<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qj', ':cnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qk', ':cprevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qn', ':silent cnewer<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qp', ':silent colder<CR>', {noremap = true, silent = true})

-- Location list
vim.api.nvim_set_keymap('n', '<leader>lo', ':lopen<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lc', ':lclose<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lj', ':lnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lk', ':lprevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ln', ':silent lnewer<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lp', ':silent lolder<CR>', {noremap = true, silent = true})

-- Git vim-fugitive
-- vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gd', ':Git diff<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gl', ":Git log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local<CR>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gfb', ':Git blame<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gfl', ":Git log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local -- %<CR>", {noremap = true, silent = true})
-- Git neogit
vim.api.nvim_set_keymap('n', '<leader>gs', ':Neogit kind=split<CR>', {noremap = true, silent = true})

-- Org mode
vim.api.nvim_set_keymap('n', '<leader>O', ':tabedit $ORG/gtd.org<CR>:lcd $ORG<CR>', {noremap = true, silent = true})

-- LSP
-- See lua/plugins/lsp-setup and lua/ftplugins/java
