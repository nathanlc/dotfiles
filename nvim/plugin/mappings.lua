-- Leader
vim.api.nvim_set_keymap('n', '<Space>', '', {noremap = true})


-- General
vim.api.nvim_set_keymap('n', 'z1', ':setlocal foldlevel=1<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'z2', ':setlocal foldlevel=2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'z3', ':setlocal foldlevel=3<CR>', {noremap = true})
vim.keymap.set({"i"}, "<D-h>", "ch", {silent = true}) -- accidental press of <D-h>


-- Commands
vim.api.nvim_set_keymap('n', '<leader>:', ':Telescope commands<CR>', {noremap = true, silent = true})


-- Navigation
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('n', 'gj', 'j', {noremap = true})
vim.api.nvim_set_keymap('n', 'gk', 'k', {noremap = true})
vim.keymap.set({'i', 's'}, 'jk', '<ESC>', {silent = true})
vim.keymap.set({'n'}, '<C-d>', '<C-d>zz', {silent = true})
vim.keymap.set({'n'}, '<C-u>', '<C-u>zz', {silent = true})
vim.keymap.set({'n'}, '*', '*zz', {silent = true})
vim.keymap.set({'n'}, '#', '#zz', {silent = true})
vim.keymap.set({'n'}, 'n', 'nzz', {silent = true})
vim.keymap.set({'n'}, 'N', 'Nzz', {silent = true})
vim.keymap.set({'n'}, 'gd', 'gdzz', {silent = true})
vim.keymap.set({'n', 'o'}, 'gs', function ()
  require('leap.remote').action()
end)


-- Indent / Format
vim.keymap.set({'v'}, '<', '<gv', {silent = true})
vim.keymap.set({'v'}, '>', '>gv', {silent = true})
vim.keymap.set({'v'}, '<leader>s', ":'<,'>sort<CR>", {silent = true})


-- Zen mode
vim.keymap.set({'n'}, '<leader>z', [[<Cmd>ZenMode<CR>]], {silent=true})


-- Buffers
-- vim.api.nvim_set_keymap('n', '<leader>bl', ':buffers<CR>:buffer', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bl', ':Telescope buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bd', ':bprevious<CR>:bdelete!#<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bD', ':bprevious<CR>:bdelete!#<CR><C-w>c', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>br', ':edit %<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bn', ':enew <CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>be', 'ggdG', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>by', 'mbggVGy`b', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bs', [[<Cmd>lua require('utils.buffer').scratch()<CR>]], {noremap = true, silent = true})
-- See LSP at bottom


-- Browser
vim.keymap.set('n', '<leader>Bl', [[<Cmd>lua require('plugins.browser_history').telescope({database = '/tmp/arc_history_db'})<CR>]], {silent = true})


-- Harpoon
local harpoon = require('harpoon')
harpoon:setup()
vim.keymap.set({'n'}, '<leader>hl', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {silent=true})
vim.keymap.set({'n'}, '<leader>ha', function() harpoon:list():add() end, {silent=true})
vim.keymap.set({'n'}, '<A-y>', function() harpoon:list():select(1) end, {silent=true})
vim.keymap.set({'n'}, '<A-u>', function() harpoon:list():select(2) end, {silent=true})
vim.keymap.set({'n'}, '<A-i>', function() harpoon:list():select(3) end, {silent=true})
vim.keymap.set({'n'}, '<A-o>', function() harpoon:list():select(4) end, {silent=true})
vim.keymap.set({'n'}, '<A-p>', function() harpoon:list():select(5) end, {silent=true})


-- Help
vim.api.nvim_set_keymap('n', '<leader>Hl', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>hs', [[<Cmd>lua require('plugins.docs').search()<CR>]], {noremap = true, silent = true})


-- Home
vim.api.nvim_set_keymap('n', '<leader>H', [[<Cmd>lua require('plugins.home').home()<CR>]], {noremap = true, silent = true})


-- Expression (under cursor)
vim.api.nvim_set_keymap('n', '<leader>xg', [[<Cmd>lua require('plugins.expression').grep()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xG', [[:silent grep <C-r><C-w> ]], {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>xs', [[<Cmd>lua require('plugins.expression').swoop()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xf', [[<Cmd>lua require('plugins.expression').find_files()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xH', [[<Cmd>lua require('plugins.expression').help_tags()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xj', [[<Cmd>lua require('plugins.expression').lsp_workspace_symbols()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xh', [[<Cmd>lua require('plugins.expression').docs()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xr', [[:%S/\<<C-r><C-w>\>//g<Left><Left>]], {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>xc', [[<Cmd>lua require('plugins.expression').cycle()<CR>]], {noremap = true})
vim.api.nvim_set_keymap('n', '<C-Space>', [[<Cmd>lua require('plugins.expression').cycle()<CR>]], {noremap = true})


-- Files
vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:write<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-s>', ':write<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fl', ':Telescope find_files hidden=true<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fo', ':Telescope oldfiles<CR>', {noremap = true, silent = true})
vim.keymap.set({"n"}, "<leader>fr", [[<Cmd>call feedkeys(":saveas %<Tab>", "tn")<CR>]], {})
vim.keymap.set({"n"}, "<leader>fs", [[<Cmd>write<CR>]], {})


-- Projects
vim.keymap.set({'n'}, '<leader>pe', [[<Cmd>lua require('plugins.project').edit_project_config()<CR>]], {silent=true})
vim.api.nvim_set_keymap('n', '<leader>pl', [[<Cmd>lua require('plugins.project').open_telescope()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pb', [[<Cmd>lua require('telescope.builtin').buffers({only_cwd = true})<CR>]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>po', [[<Cmd>lua require('telescope.builtin').oldfiles({only_cwd = true})<CR>]], {silent=true})
vim.api.nvim_set_keymap('n', '<leader>p"', [[<Cmd>lua require('plugins.project').project_terms_picker()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pa', ':A<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pv', ':Make<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pc', [[<Cmd>lua require('plugins.project').run_console()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pr', [[<Cmd>lua require('plugins.project').run_repl()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pR', [[<Cmd>lua require('plugins.project').reload_config()<CR>]], {noremap = true})
vim.keymap.set({'n'}, '<leader>pj', [[<Cmd>lua require('plugins.project').open_jira()<CR>]], {silent=true})


-- Tasks
vim.keymap.set({'n'}, '<leader>to', [[<Cmd>OverseerOpen left<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tl', [[<Cmd>OverseerRun<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tf', [[<Cmd>lua require("overseer").run_template({ tags = { "test_file" } })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tF', [[<Cmd>lua require("plugins.project").run_test({ target = "file" })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tp', [[<Cmd>lua require("overseer").run_template({ tags = { "test_project" } })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tc', [[<Cmd>lua require("overseer").run_template({ tags = { "check" } })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tr', [[<Cmd>lua require("plugins.overseer").restart_latest_task()<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>ts', [[<Cmd>OverseerQuickAction open hsplit<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tv', [[<Cmd>OverseerQuickAction open vsplit<CR>]], {silent = true})
-- vim.keymap.set({'n'}, '<leader>ts', require('plugins.project').run_test_suite, {silent = true})
-- vim.keymap.set({'n'}, '<leader>tc', function()
--     require('plugins.project').run_test_current(
--         vim.api.nvim_get_current_buf(),
--         vim.api.nvim_win_get_cursor(0)[1]
--     ) end, {silent = true})


-- Print info
vim.api.nvim_set_keymap('n', '<leader>Pp', '<Cmd>pwd<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Pf', '<Cmd>echo expand("%")<CR>', {noremap = true, silent = true})


-- Undo tree
vim.keymap.set({'n'}, '<leader>uo', require('undotree').open, {silent=true})
vim.keymap.set({'n'}, '<leader>uc', require('undotree').close, {silent=true})


-- Yank / paste
vim.keymap.set({'n'}, 'Y', 'yg_', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>yf', ':let @+=@%<CR>', {noremap = true, silent = true})
vim.keymap.set({'v'}, '<leader>p', '"_dP', {silent = true})
vim.keymap.set({'n'}, 'gp', '`[v`]', {silent = true})
-- vim.keymap.set({'v'}, '<C-j>', [[:'<,'>move +1<CR>gv]], {silent = true})
-- vim.keymap.set({'v'}, '<C-k>', [[:'<,'>move -2<CR>gv]], {silent = true})


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
vim.keymap.set({'n'}, '<leader>wp', '<C-w><C-p>', {silent = true})
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
vim.keymap.set({'n'}, '<D-h>', '5<C-w><', {silent = true})
vim.keymap.set({'n'}, '<A-C-h>', '5<C-w><', {silent = true})
vim.keymap.set({'n'}, '<D-j>', '<Cmd>resize -5<CR>', {silent = true})
vim.keymap.set({'n'}, '<A-C-j>', '<Cmd>resize -5<CR>', {silent = true})
vim.keymap.set({'n'}, '<D-k>', '<Cmd>resize +5<CR>', {silent = true})
vim.keymap.set({'n'}, '<A-C-k>', '<Cmd>resize +5<CR>', {silent = true})
vim.keymap.set({'n'}, '<D-l>', '5<C-w>>', {silent = true})
vim.keymap.set({'n'}, '<A-C-l>', '5<C-w>>', {silent = true})


-- Search
vim.keymap.set({'n'}, '<Esc>', [[<Esc><Cmd>nohlsearch<CR>]], {silent=true})
vim.keymap.set({'v'}, '*', '"vy/<C-r>v<CR>', {silent=true})
vim.keymap.set({'v'}, '#', '"vy?<C-r>v<CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<leader>sg', ':Telescope live_grep<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sG', ':silent grep ', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>sf', ':Telescope current_buffer_fuzzy_find<CR>', {noremap = true, silent = true})
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
vim.keymap.set({'n'}, '<D-&>', '1gt', {silent = true})
vim.keymap.set({'n'}, '<D-é>', '2gt', {silent = true})
vim.keymap.set({'n'}, '<D-">', '3gt', {silent = true})
vim.keymap.set({'n'}, "<D-'>", '4gt', {silent = true})
vim.keymap.set({'n'}, "<D-(>", '5gt', {silent = true})
vim.keymap.set({'n'}, '<D-1>', '1gt', {silent = true})
vim.keymap.set({'n'}, '<D-2>', '2gt', {silent = true})
vim.keymap.set({'n'}, '<D-3>', '3gt', {silent = true})
vim.keymap.set({'n'}, "<D-4>", '4gt', {silent = true})
vim.keymap.set({'n'}, "<D-5>", '5gt', {silent = true})
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
vim.api.nvim_set_keymap('n', '<leader>!h', ':set hlsearch!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>!l', ':setlocal wrap!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>!wh', ':set winfixheight!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>!c', ':TSContextToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>!n', ':set number!<CR>:set relativenumber!<CR>', {noremap = true})


-- Terminal
vim.api.nvim_set_keymap('n', '<leader>"n', [[<Cmd>lua require('utils.term').open_small_term()<CR>i]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>"o', [[<Cmd>term<CR>i]], {silent = true})
vim.keymap.set({'n'}, '<leader>"s', [[<Cmd>split | term<CR>i]], {silent = true})
vim.keymap.set({'n'}, '<leader>"v', [[<Cmd>vsplit | term<CR>i]], {silent = true})
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
vim.api.nvim_set_keymap('n', '<leader>eh', '<Cmd>lua vim.diagnostic.hide()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>es', '<Cmd>lua vim.diagnostic.show()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>el', '<Cmd>lua vim.diagnostic.setloclist()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>eq', '<Cmd>lua vim.diagnostic.setqflist()<CR>', {noremap = true, silent = true})


-- Quickfix list
vim.api.nvim_set_keymap('n', '<leader>qo', ':copen 16<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qc', ':cclose<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qj', ':cnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qk', ':cprevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qn', ':silent cnewer<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qp', ':silent colder<CR>', {noremap = true, silent = true})


-- Location list
vim.api.nvim_set_keymap('n', '<leader>lo', ':lopen 16<CR>', {noremap = true, silent = true})
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
vim.keymap.set({'n'}, '<leader>gg', "<Cmd>GBrowse<CR>", {silent = true})
vim.keymap.set({'n'}, '<leader>gd', "<Cmd>Gdiffsplit<CR>", {silent = true})
vim.keymap.set({'n'}, '<leader>gc', ":!gh pr create --fill --draft && gh pr view --web<CR>", {silent = true})
vim.keymap.set({'n'}, '<leader>gj', require('plugins.github').pr_checks, {silent = true}) -- "j" for jenkins
vim.keymap.set({'n'}, '<leader>gv', ":!gh pr view --web<CR>", {silent = true})


-- Debug (DAP)
vim.keymap.set({'n'}, '<leader>dc', function() require('dap').continue() end, {silent=true})
vim.keymap.set({'n'}, '<leader>db', function() require('dap').toggle_breakpoint() end, {silent=true})
vim.keymap.set({'n'}, '<leader>dn', function() require('dap').step_over() end, {silent=true})
vim.keymap.set({'n'}, '<leader>di', function() require('dap').step_into() end, {silent=true})
vim.keymap.set({'n'}, '<leader>do', function() require('dap').step_out() end, {silent=true})
vim.keymap.set({'n'}, '<leader>dt', function() require('dap').terminate() end, {silent=true})


-- Open
vim.keymap.set({'n'}, '<leader>od', function() require('oil').open('~/Downloads') end, {silent=true})
vim.keymap.set({'n'}, '<leader>os', [[<Cmd>edit ~/.ssh/config<CR>]], {silent=true})
vim.keymap.set({'n'}, '<leader>om', [[<Cmd>edit ~/Dropbox/neorg/meetings.norg<CR>]], {silent=true})
vim.keymap.set({'n'}, '<leader>ot', [[<Cmd>edit ~/Dropbox/neorg/todos.norg<CR>]], {silent=true})
vim.keymap.set({'n'}, '<leader>oT', [[<Cmd>tabedit ~/Dropbox/neorg/todos.norg<CR>]], {silent=true})


-- Org mode
vim.api.nvim_set_keymap('n', '<leader>O', ':tabedit $ORG/gtd.org<CR>:lcd $ORG<CR>', {noremap = true, silent = true})


-- Config / Clipboard
vim.keymap.set({'n'}, '<leader>cc', function() require('plugins.project').open_project_tab('~/sandbox/mine/dotfiles') end, {silent=true})
vim.keymap.set({'n'}, '<leader>cs', [[<Cmd>Lazy sync<CR>]], {silent=true})

vim.keymap.set({'n'}, '<leader>cl', function() require('plugins.clipboard').telescope() end, {silent=true})
vim.keymap.set({'n'}, '<leader>ce', function() require('plugins.clipboard').edit() end, {silent=true})


-- File explorer
vim.keymap.set({"n"}, "-", require("oil").open, {silent=true})
-- See nvim/lua/plugins/oil.lua for oil keymaps


-- Mason
vim.keymap.set({'n'}, '<leader>M', '<Cmd>Mason<CR>', {silent=true})


-- Manipulation of text
vim.keymap.set({'n'}, '<leader>ms', '<Cmd>TSJSplit<CR>', {silent=true})
vim.keymap.set({'n'}, '<leader>mj', '<Cmd>TSJJoin<CR>', {silent=true})


-- Insert text
vim.keymap.set({'n'}, '<leader>imm', [[oimethod<Plug>luasnip-expand-or-jump]], {silent=true})
vim.keymap.set({'n'}, '<leader>imp', [[<Cmd>lua require("nvim-treesitter.textobjects.move").goto_previous_start('@function.outer')<CR>Oimethod<Plug>luasnip-expand-or-jump]], {silent=true})
vim.keymap.set({'n'}, '<leader>imn', [[<Cmd>lua require("nvim-treesitter.textobjects.move").goto_next_start('@function.outer')<CR>Oimethod<Plug>luasnip-expand-or-jump]], {silent=true})


-- Go to (Opener)
vim.keymap.set({'n'}, 'gx', require('open').open_cword, {silent=true})


-- Gcal
-- vim.keymap.set({'n'}, '<leader>aa', require('plugins.gcal').add, {silent=true})


-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('nathanlc', {clear=true}),
    callback = function(_, bufnr)
        local bufopts = { silent = true, buffer = bufnr }
        -- -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', [[<Cmd>lua require('telescope.builtin').lsp_definitions({initial_mode = 'normal'})<CR>]], bufopts)
        vim.keymap.set('n', 'gD', [[<CMD>vsplit<CR><Cmd>lua require('telessope.builtin').lsp_definitions()<CR>]], bufopts)
        vim.keymap.set('n', 'gi', [[<Cmd>lua require('telessope.builtin').lsp_implementations({initial_mode = 'normal'})<CR>]], bufopts)
        vim.keymap.set('n', 'gr', [[<Cmd>lua require('telescope.builtin').lsp_references({initial_mode = 'normal'})<CR>]], bufopts)
        vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)
        -- -- vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'H', vim.lsp.buf.signature_help, bufopts)
        -- -- vim.keymap.set('n', '<leader>Wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        -- -- vim.keymap.set('n', '<leader>Wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        -- -- vim.keymap.set('n', '<leader>Wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        vim.keymap.set('n', '<leader>rb', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, bufopts)
        -- -- vim.keymap.set("n", "<leader>I", [[<Cmd>lua print(vim.inspect(vim.lsp.get_clients({buffer=bufnr})[1].resolved_capabilities))<CR>]], bufopts)
        vim.keymap.set("n", "<leader>pjs", [[<Cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]], bufopts)
        vim.keymap.set("n", "<leader>pjc", [[<Cmd>lua require('telescope.builtin').lsp_workspace_symbols({default_text = ':class: '})<CR>]], bufopts)
        vim.keymap.set("n", "<leader>pjf", [[<Cmd>lua require('telescope.builtin').lsp_workspace_symbols({default_text = ':function: '})<CR>]], bufopts)
        vim.keymap.set("n", "<leader>pjm", [[<Cmd>lua require('telescope.builtin').lsp_workspace_symbols({default_text = ':method: '})<CR>]], bufopts)
    end
})


-- Filetypes specifics

-- ruby
local nathan_lc_group = vim.api.nvim_create_augroup('nathanlc_ft_mappings', {clear=true})
vim.api.nvim_create_autocmd('FileType', {
    group = nathan_lc_group,
    pattern = {"ruby", "rb", "erb"},
    callback = function()
        vim.schedule(function()
            vim.keymap.set('n', '<leader>pa', ':R<CR>', {silent=true, buffer=true})
        end)
    end
})

-- quickfix list
vim.api.nvim_create_autocmd('FileType', {
    group = nathan_lc_group,
    pattern = {"qf"},
    callback = function()
        vim.schedule(function()
            vim.keymap.set('n', '<C-Space>', '<CR>:copen<CR>', {silent=true, buffer=true})
        end)
    end
})

-- norg / neorg
vim.api.nvim_create_autocmd('FileType', {
    group = nathan_lc_group,
    pattern = {"norg"},
    callback = function()
        vim.schedule(function()
            vim.keymap.set('n', '<C-Space>', '<Plug>(neorg.qol.todo-items.todo.task-cycle)', {silent=true, buffer=true})
        end)
    end
})

