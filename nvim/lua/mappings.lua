-- Leader
vim.api.nvim_set_keymap('n', '<Space>', '', {noremap = true})
vim.g.mapleader = ' '

-- General
vim.api.nvim_set_keymap('n', 'z1', ':setlocal foldlevel=1<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'z2', ':setlocal foldlevel=2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'z3', ':setlocal foldlevel=3<CR>', {noremap = true})

-- Comments
-- See ./lua/plugins/comment.lua

-- Commands
vim.api.nvim_set_keymap('n', '<leader>:', ':Telescope commands<CR>', {noremap = true, silent = true})

-- Navigation
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('n', 'gj', 'j', {noremap = true})
vim.api.nvim_set_keymap('n', 'gk', 'k', {noremap = true})
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true})

-- Command
-- vim.api.nvim_set_keymap('c', '<C-b>', '<Left>', {noremap = true})
-- vim.api.nvim_set_keymap('c', '<C-f>', '<Right>', {noremap = true})
-- vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', {noremap = true})
-- vim.api.nvim_set_keymap('c', '<C-e>', '<End>', {noremap = true})
-- vim.api.nvim_set_keymap('c', '<C-d>', '<Delete>', {noremap = true})

-- Zen mode
vim.keymap.set({'n'}, '<leader>z', [[<Cmd>:ZenMode<CR>]], {silent=true})

-- Buffers
-- vim.api.nvim_set_keymap('n', '<leader>bl', ':buffers<CR>:buffer', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bl', ':Telescope buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bd', ':bprevious<CR>:bdelete!#<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bD', ':bprevious<CR>:bdelete!#<CR><C-w>c', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>br', ':edit %<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bn', ':enew <CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>be', 'ggdG', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bs', [[<Cmd>lua require('utils.buffer').scratch()<CR>]], {noremap = true, silent = true})

-- Browser
vim.keymap.set('n', '<leader>Bl', [[<Cmd>lua require('plugins.browser_history').telescope({database = '/tmp/arc_history_db'})<CR>]], {silent = true})

-- Help
vim.api.nvim_set_keymap('n', '<leader>Hl', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], {noremap = true, silent = true})

-- Home
vim.api.nvim_set_keymap('n', '<leader>H', [[<Cmd>lua require('plugins.home').home()<CR>]], {noremap = true, silent = true})

-- Expression (under cursor)
vim.api.nvim_set_keymap('n', '<leader>xg', [[<Cmd>lua require('plugins.expression').grep()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xs', [[<Cmd>lua require('plugins.expression').swoop()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xf', [[<Cmd>lua require('plugins.expression').find_files()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xh', [[<Cmd>lua require('plugins.expression').help_tags()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xj', [[<Cmd>lua require('plugins.expression').lsp_workspace_symbols()<CR>]], {noremap = true, silent = true})

-- Files
vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:write<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-s>', ':write<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fl', ':Telescope find_files hidden=true<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fL', [[<Cmd>lua require('commands').find_files()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fo', ':Telescope oldfiles<CR>', {noremap = true, silent = true})
vim.keymap.set({"n"}, "<leader>fr", [[<Cmd>call feedkeys(":saveas %<Tab>", "tn")<CR>]], {})
vim.keymap.set({"n"}, "<leader>fs", [[<Cmd>write<CR>]], {})

-- Projects
vim.api.nvim_set_keymap('n', '<leader>pl', [[<Cmd>lua require('plugins.project.project').open_telescope()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pb', [[<Cmd>lua require('telescope.builtin').buffers({only_cwd = true})<CR>]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>po', [[<Cmd>lua require('telescope.builtin').oldfiles({only_cwd = true})<CR>]], {silent=true})
vim.api.nvim_set_keymap('n', '<leader>p"', [[<Cmd>lua require('plugins.project.project').project_terms_picker()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pa', ':A<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pv', ':Make<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pc', [[<Cmd>lua require('plugins.project.project').run_console()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pr', [[<Cmd>lua require('plugins.project.project').run_repl()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pL', [[<Cmd>lua require('plugins.project.project').run_logs()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pR', [[<Cmd>lua require('plugins.project.project').reload_config()<CR>]], {noremap = true})

-- Test
vim.keymap.set({'n'}, '<leader>tt', [[<Cmd>OverseerToggle!<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>to', [[<Cmd>OverseerOpen<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tl', [[<Cmd>OverseerRun<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tf', [[<Cmd>lua require("overseer").run_template({ tags = { "test_file" } })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tp', [[<Cmd>lua require("overseer").run_template({ tags = { "test_project" } })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tc', [[<Cmd>lua require("overseer").run_template({ tags = { "check" } })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tr', [[<Cmd>lua require("plugins.task-runner").restart_latest_task()<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>ts', [[<Cmd>OverseerQuickAction open hsplit<CR>]], {silent = true})
-- vim.keymap.set({'n'}, '<leader>ts', require('plugins.project.project').run_test_suite, {silent = true})
-- vim.keymap.set({'n'}, '<leader>tc', function()
--     require('plugins.project.project').run_test_current(
--         vim.api.nvim_get_current_buf(),
--         vim.api.nvim_win_get_cursor(0)[1]
--     ) end, {silent = true})

-- Print info
vim.api.nvim_set_keymap('n', '<leader>Pp', '<Cmd>pwd<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Pf', '<Cmd>echo expand("%")<CR>', {noremap = true, silent = true})

-- Yank
vim.api.nvim_set_keymap('n', '<leader>yf', ':let @+=@%<CR>', {noremap = true, silent = true})

-- Windows
vim.api.nvim_set_keymap('n', '<leader>w', '<C-w>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>wh', '<C-w>H', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>wj', '<C-w>J', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>wk', '<C-w>K', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>wl', '<C-w>L', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>wd', '<C-w>c', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>wS', ':leftabove split<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>wV', ':leftabove vsplit<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>wm', [[<Cmd>lua require('utils.window').make_small()<CR>]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>wp', '<C-w><C-p>', {noremap = true, silent = true})
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
vim.api.nvim_set_keymap('n', '<leader>sg', ':Telescope live_grep<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sG', ':silent grep ', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ss', ':Telescope current_buffer_fuzzy_find<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sr', [[<Cmd>lua require('telescope.builtin').resume({initial_mode = "normal"})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sl', [[<Cmd>lua require('telescope.builtin').pickers({initial_mode = "normal"})<CR>]], {noremap = true, silent = true})


-- Session
local session_file_path = vim.fn.stdpath('cache') .. '/Session.vim'
vim.keymap.set({'n'}, '<leader>ks', '<Cmd>mksession! ' .. session_file_path .. '<CR>', {})
vim.keymap.set({'n'}, '<leader>kr', '<Cmd>source ' .. session_file_path .. '<CR>', {silent = true})

-- Jump
vim.api.nvim_set_keymap('n', '<leader>js', [[<Cmd>lua require('telescope.builtin').treesitter({})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jf', [[<Cmd>lua require('telescope.builtin').treesitter({default_text = ':function: '})<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jm', [[<Cmd>lua require('telescope.builtin').treesitter({default_text = ':method: '})<CR>]], {noremap = true, silent = true})

-- Tabs
vim.api.nvim_set_keymap('n', 'Te', ':tabedit ', {noremap = true})
vim.api.nvim_set_keymap('n', 'Tr', ':LualineRenameTab ', {noremap = true})
vim.api.nvim_set_keymap('n', 'Tc', [[:tabnew<CR><Cmd>lua require('plugins.home').home()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T<', ':-tabmove<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T>', ':+tabmove<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'To', ':tabonly<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'Td', ':tabclose<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T1', '1gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T2', '2gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T3', '3gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T4', '4gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T5', '5gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T6', '6gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T7', '7gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T8', '8gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'T9', '9gt', {noremap = true, silent = true})

-- Toggle
vim.api.nvim_set_keymap('n', '<leader>Th', ':set hlsearch!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Tl', ':setlocal wrap!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Twh', ':set winfixheight!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Tc', ':TSContextToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Tn', ':set number!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Trn', ':set relativenumber!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Ti', [[<Cmd>IBLToggle<CR>]], {noremap = true, silent = true})

-- Terminal
vim.api.nvim_set_keymap('n', '<leader>"n', [[<Cmd>lua require('utils.term').open_small_term()<CR>i]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>"o', [[<Cmd>term<CR>i]], {silent = true})
vim.api.nvim_set_keymap('n', '<leader>"l', [[<Cmd>lua require('telescope.builtin').buffers({default_text = "term://", initial_mode = "normal"})<CR>]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>"t', [[<Cmd>tabnew | term<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>"r', [[<Cmd>lua require('plugins.term').history()<CR>]], {silent = true})
vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-N>', {noremap = true})
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-N>', {noremap = true})
vim.api.nvim_set_keymap('t', '<A-h>', [[<Cmd>wincmd h<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-j>', [[<Cmd>wincmd j<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-k>', [[<Cmd>wincmd k<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-l>', [[<Cmd>wincmd l<CR>]], {noremap = true, silent = true})

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('nathanlc:TermOpen', {clear=true}),
    pattern = {"*"},
    callback = function()
      vim.keymap.set({'n'}, '<C-p>', 'i<C-p>', {buffer=true})
    end
})

-- Diagnostic
vim.api.nvim_set_keymap('n', '<leader>ed', '<Cmd>lua vim.diagnostic.open_float()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ep', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>en', '<Cmd>lua vim.diagnostic.goto_next()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>el', '<Cmd>lua vim.diagnostic.setloclist()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>eq', '<Cmd>lua vim.diagnostic.setqflist()<CR>', {noremap = true, silent = true})

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

-- vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gd', ':Git diff<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gl', ":Git log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local<CR>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gfb', ':Git blame<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gfl', ":Git log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local -- %<CR>", {noremap = true, silent = true})
-- Git 
vim.api.nvim_set_keymap('n', '<leader>gs', ':Neogit<CR>', {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>gS', [[<Cmd>:Git<CR>]], {silent=true})
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>gl', '<Cmd>Telescope git_bcommits<CR>', {silent=true})
vim.keymap.set({'v'}, '<leader>gl', '<Cmd>Telescope git_bcommits_range<CR>', {silent=true})
vim.keymap.set({'n'}, '<leader>gL', '<Cmd>Telescope git_commits<CR>', {silent=true})
vim.keymap.set({'n'}, '<leader>gg', [[<Cmd>GBrowse<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>gd', [[<Cmd>Gdiffsplit<CR>]], {silent = true})


-- Debug (DAP)
vim.keymap.set({'n'}, '<leader>dc', function() require('dap').continue() end, {silent=true})
vim.keymap.set({'n'}, '<leader>db', function() require('dap').toggle_breakpoint() end, {silent=true})
vim.keymap.set({'n'}, '<leader>dn', function() require('dap').step_over() end, {silent=true})
vim.keymap.set({'n'}, '<leader>di', function() require('dap').step_into() end, {silent=true})
vim.keymap.set({'n'}, '<leader>do', function() require('dap').step_out() end, {silent=true})
vim.keymap.set({'n'}, '<leader>dt', function() require('dap').terminate() end, {silent=true})

-- Org mode
vim.api.nvim_set_keymap('n', '<leader>O', ':tabedit $ORG/gtd.org<CR>:lcd $ORG<CR>', {noremap = true, silent = true})

-- Copilot
vim.keymap.set({'n'}, '<leader>Cp', '<Cmd>Copilot panel<CR>', {silent=true})


-- Clipboards
vim.keymap.set({'n'}, '<leader>cl', [[<Cmd>lua require('plugins.clipboard').telescope()<CR>]], {silent=true})


-- File explorer
vim.keymap.set({"n"}, "-", require("oil").open, {silent=true})
-- See nvim/lua/plugins/file-explorer.lua for oil keymaps

-- Mason
vim.keymap.set({'n'}, '<leader>M', '<Cmd>Mason<CR>', {silent=true})


-- Manipulation of text
vim.keymap.set({'n'}, '<leader>ms', '<Cmd>TSJSplit<CR>', {silent=true})
vim.keymap.set({'n'}, '<leader>mj', '<Cmd>TSJJoin<CR>', {silent=true})


-- Go to (Opener)
vim.keymap.set({'n'}, 'gx', require('open').open_cword, {silent=true})


-- Snippets
local luasnip = require('luasnip')
vim.keymap.set({'i', 's'}, '<C-i>', function()
    if luasnip.expandable() then
        luasnip.expand({})
    end
end, { silent = true })
vim.keymap.set({'i', 's'}, '<C-j>', function()
    if luasnip.jumpable(1) then
        luasnip.jump(1)
    end
end, { silent = true })
vim.keymap.set({'i', 's'}, '<C-k>', function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })
-- vim.keymap.set({'i'}, '<C-l>', function()
--     if luasnip.choice_active() then
--         luasnip.change_choice(1)
--     end
-- end)

-- Mail
-- vim.api.nvim_set_keymap('n', '<leader>M', ':Himalaya<CR>', {noremap = true, silent = true})

-- LSP
-- See lua/plugins/lsp-setup and lua/ftplugins/java
