-- Leader
vim.api.nvim_set_keymap('n', '<Space>', '', {noremap = true})


-- General
vim.api.nvim_set_keymap('n', 'z1', ':setlocal foldlevel=1<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'z2', ':setlocal foldlevel=2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'z3', ':setlocal foldlevel=3<CR>', {noremap = true})
vim.keymap.set({"i"}, "<D-h>", "ch", {silent = true}) -- accidental press of <D-h>
vim.keymap.set({"i"}, "<C-b>", "<Left>", {silent = true})
vim.keymap.set({"i"}, "<C-f>", "<Right>", {silent = true})


-- Jumplist
vim.keymap.set({"n"}, "<leader><C-o>", [[<Cmd>lua require("plugins.jumplist").jump_to_previous_file()<CR>]], {silent = true}) -- accidental press of <D-h>
vim.keymap.set({"n"}, "<leader><C-i>", [[<Cmd>lua require("plugins.jumplist").jump_to_next_file()<CR>]], {silent = true}) -- accidental press of <D-h>

-- Commands
vim.api.nvim_set_keymap('n', '<leader>:', ':FzfLua commands<CR>', {noremap = true, silent = true})


-- Navigation
vim.keymap.set({'i', 's'}, 'jk', '<ESC>', {silent = true})
vim.keymap.set({'n'}, '<C-d>', '<C-d>zz', {silent = true})
vim.keymap.set({'n'}, '<C-u>', '<C-u>zz', {silent = true})
vim.keymap.set({'n'}, '*', '*zz', {silent = true})
vim.keymap.set({'n'}, '#', '#zz', {silent = true})
vim.keymap.set({'n'}, 'n', 'nzz', {silent = true})
vim.keymap.set({'n'}, 'N', 'Nzz', {silent = true})
vim.keymap.set({'n'}, 'gd', 'gdzz', {silent = true})
vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set({'n', 'o'}, 'gS', '<Plug>(leap-from-window)')
vim.keymap.set({'n', 'o'}, 'gs', function() require('leap.remote').action({}) end)
vim.keymap.set({'n', 'o', 'v'}, 'H', '_', {silent = true})
vim.keymap.set({'n', 'o', 'v'}, 'L', 'g_', {silent = true})
vim.keymap.set({'n', 'o'}, 'U', '<C-^>', {silent = true})
vim.keymap.set({'i', 't'}, ';U', '<C-^>', {silent = true})


-- Indent / Format
vim.keymap.set({'v'}, '<', '<gv', {silent = true})
vim.keymap.set({'v'}, '>', '>gv', {silent = true})
vim.keymap.set({'v'}, '<leader>s', ":'<,'>sort<CR>", {silent = true})


-- Zen mode
vim.keymap.set({'n'}, '<leader>z', [[<Cmd>ZenMode<CR>]], {silent=true})


-- Buffers
-- vim.api.nvim_set_keymap('n', '<leader>bl', ':buffers<CR>:buffer', {noremap = true})
vim.keymap.set({"n"}, '<leader>bl', [[<Cmd>FzfLua buffers<CR>]], {silent = true})
vim.api.nvim_set_keymap('n', '<leader>bd', ':bprevious<CR>:bdelete!#<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bD', ':bprevious<CR>:bdelete!#<CR><C-w>c', {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>br', ':edit %<CR>', {noremap = true})
vim.keymap.set({'n'}, '<leader>bR', '<Cmd>enew<CR><Cmd>bdelete!#<CR><Cmd>e #<CR><Cmd>bdelete!#<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bn', ':enew <CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>be', 'ggdG', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>by', 'mbggVGy`b', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bs', [[<Cmd>lua require('utils.buffer').scratch()<CR>]], {noremap = true, silent = true})
-- See LSP at bottom


-- Browser
-- vim.keymap.set('n', '<leader>Bl', [[<Cmd>lua require('plugins.browser_history').telescope({database = '/tmp/arc_history_db'})<CR>]], {silent = true})


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
vim.keymap.set({'n'}, '<leader>Hl', [[<Cmd>FzfLua helptags<CR>]], {silent=true})
vim.api.nvim_set_keymap('n', '<leader>hs', [[<Cmd>lua require('plugins.docs').search()<CR>]], {noremap = true, silent = true})


-- Home
vim.api.nvim_set_keymap('n', '<leader>H', [[<Cmd>lua require('plugins.home').home()<CR>]], {noremap = true, silent = true})


-- Refactor
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set( "n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- Expression (under cursor)
vim.api.nvim_set_keymap('n', '<leader>xg', [[<Cmd>lua FzfLua.live_grep({ query = require("plugins.expression").current_symbol() })<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xG', [[:silent grep <C-r><C-w> ]], {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>xf', [[<Cmd>lua FzfLua.files({ query = require("plugins.expression").current_symbol_to_file() })<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xH', [[<Cmd>lua FzfLua.helptags({ query = require("plugins.expression").current_symbol() })<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>xh', [[<Cmd>lua require('plugins.expression').docs()<CR>]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>xp', 'viwP', {silent = true})
vim.keymap.set({'n'}, '<leader>xU', 'gUiw', {silent = true})
vim.keymap.set({'n'}, '<leader>xu', 'guiw', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Space>', [[<Cmd>lua require('plugins.expression').cycle()<CR>]], {noremap = true})


-- Files
-- vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:write<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-s>', ':write<CR>', {noremap = true, silent = true})
vim.keymap.set({"n"}, '<leader>fl', [[<Cmd>FzfLua files<CR>]], {silent = true})
vim.keymap.set({"n"}, '<leader>ft', function() require("nvim-tree.api").tree.toggle({find_file = false, focus = true, current_window = true}) end, {silent = true})
vim.keymap.set({"n"}, "<leader>fo", [[<Cmd>FzfLua oldfiles<CR>]], {silent = true})
vim.keymap.set({"n"}, "<leader>fr", [[<Cmd>call feedkeys(":saveas %<Tab>", "tn")<CR>]], {})
vim.keymap.set({"n"}, "<leader>fs", [[<Cmd>write<CR>]], {})


-- Projects
vim.keymap.set({'n'}, '<leader>pe', [[<Cmd>lua require('plugins.project').edit_project_config()<CR>]], {silent=true})
vim.keymap.set({"n"}, "<leader>po", [[<Cmd>lua FzfLua.oldfiles({ cwd_only = true})<CR>]], {silent = true})
vim.api.nvim_set_keymap('n', '<leader>pa', ':A<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>pv', ':Make<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pR', [[<Cmd>lua require('plugins.project').reload_config()<CR>]], {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>pr', [[<Cmd>lua require('plugins.project').repl()<CR>]], {noremap = true})
vim.keymap.set({'n'}, '<leader>pj', [[<Cmd>lua require('plugins.project').open_jira()<CR>]], {silent=true})


-- Tasks
vim.keymap.set({'n'}, '<leader>to', [[<Cmd>OverseerOpen bottom<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>t!', [[<Cmd>OverseerToggle<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tl', [[<Cmd>OverseerRun<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tf', [[<Cmd>lua require("overseer").run_task({ tags = { "test_file" } })<CR>]], {silent = true})
-- vim.keymap.set({'n'}, '<leader>tF', [[<Cmd>lua require("plugins.project").run_test({ target = "file" })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tp', [[<Cmd>lua require("overseer").run_template({ tags = { "test_project" } })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tc', [[<Cmd>lua require("overseer").run_template({ tags = { "check" } })<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>tr', [[<Cmd>lua require("plugins.overseer").restart_latest_task()<CR>]], {silent = true})
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
vim.keymap.set({'n'}, 'gy', 'gvy', {silent = true})
vim.keymap.set({'n'}, 'Y', 'yg_', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>yf', ':let @+=@%<CR>', {noremap = true, silent = true})
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
vim.keymap.set({'n'}, '<leader>wm', [[<Cmd>lua vim.api.nvim_win_set_height(0, 15)<CR>]], {silent = true})
vim.keymap.set({'n'}, '<leader>wf', function()
    local file = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
    vim.cmd('vsplit ' .. file)
end, {silent = true})
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
vim.api.nvim_set_keymap('n', '<leader>sg', ':FzfLua live_grep<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sG', ':silent grep ', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>sr', [[<Cmd>FzfLua resume<CR>]], {noremap = true, silent = true})


-- Session
local session_file_path = vim.fn.stdpath('cache') .. '/Session.vim'
vim.keymap.set({'n'}, '<leader>ks', '<Cmd>mksession! ' .. session_file_path .. '<CR>', {})
vim.keymap.set({'n'}, '<leader>kr', '<Cmd>source ' .. session_file_path .. '<CR>', {silent = true})


-- Jump
vim.keymap.set({'n'}, '<leader>js', [[<Cmd>FzfLua treesitter<CR>]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>jf', [[<Cmd>lua FzfLua.treesitter({ query = "[function] " })<CR>]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>jm', [[<Cmd>lua FzfLua.treesitter({ query = "[method] " })<CR>]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>jc', [[<Cmd>lua FzfLua.treesitter({ query = "[class] " })<CR>]], {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>jt', [[<Cmd>lua FzfLua.treesitter({ query = "[type] " })<CR>]], {noremap = true, silent = true})


-- Tabs
vim.api.nvim_set_keymap('n', 'Te', ':tabedit ', {noremap = true})
vim.api.nvim_set_keymap('n', 'Tr', ':LualineRenameTab ', {noremap = true})
vim.api.nvim_set_keymap('n', 'Tc', [[<Cmd>tabnew<CR>]], {noremap = true, silent = true})
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
vim.api.nvim_set_keymap('n', '<leader>!c', ':TSContext toggle<CR>', {noremap = true})
vim.keymap.set({'n'}, '<leader>!d', function ()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled({bufnr = 0}), {bufnr = 0})
end, {silent = true})
vim.api.nvim_set_keymap('n', '<leader>!h', ':set hlsearch!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>!l', ':setlocal wrap!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>!n', ':set number!<CR>:set relativenumber!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>!s', ':setlocal spell!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>!w', [[<Cmd>lua require("plugins.win-hoarder-layout").toggle_enabled()<CR>]], {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>!r', ':set lazyredraw!<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>>', [[<Cmd>lua require("plugins.win-hoarder-layout").toggle_expand_horizontal_direction()<CR>]], {noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader><', [[<Cmd>lua require("plugins.win-hoarder-layout").toggle_expand_horizontal_direction()<CR>]], {noremap = true})


-- Terminal
vim.api.nvim_set_keymap('n', "<leader>'n", [[<Cmd>lua require('utils.term').open_small_term()<CR>i]], {noremap = true, silent = true})
vim.keymap.set({'n'}, "<leader>'o", [[<Cmd>term<CR>i]], {silent = true})
vim.keymap.set({'n'}, "<leader>'s", [[<Cmd>split | term<CR>i]], {silent = true})
vim.keymap.set({'n'}, "<leader>'v", [[<Cmd>vsplit | term<CR>i]], {silent = true})
vim.keymap.set({'n'}, "<leader>'l", [[<Cmd>lua FzfLua.buffers({ query = "term://", winopts = { preview = { hidden = false }}})<CR>]], {silent = true})
vim.keymap.set({'n'}, "<leader>'y", [[<Cmd>lua require("plugins.term").create_or_focus("TESTS")<CR>]], {silent = true})
vim.keymap.set({'n'}, "<leader>'u", [[<Cmd>lua require("plugins.term").create_or_focus("STUFF")<CR>]], {silent = true})
vim.keymap.set({'n'}, "<leader>'i", [[<Cmd>lua require("plugins.term").create_or_focus("Why do I even exist?")<CR>]], {silent = true})
vim.keymap.set({'n'}, "<leader>'t", [[<Cmd>tabnew | term<CR>]], {silent = true})
vim.keymap.set({'n'}, "<leader>'h", [[<Cmd>lua require('plugins.term').history()<CR>]], {silent = true})
-- vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-N>', {noremap = true}) -- This prevents from using some tuis where j is used to scroll down.
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-N>', {noremap = true})
vim.api.nvim_set_keymap('t', '<A-h>', [[<Cmd>wincmd h<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-j>', [[<Cmd>wincmd j<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-k>', [[<Cmd>wincmd k<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-l>', [[<Cmd>wincmd l<CR>]], {noremap = true, silent = true})

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('nathanlc:TermOpen', {clear=true}),
    pattern = {"*"},
    callback = function()
        local term = require('plugins.term')
        -- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        vim.schedule(function()
            vim.cmd('setlocal nospell')
            vim.keymap.set({'n'}, '<C-p>', 'i<C-p>', {buffer=true})
            vim.keymap.set({'n', 'x', 'o'}, '[l', function()
                -- local bufnr = vim.api.nvim_get_current_buf()
                -- term.jump_previous_prompt({bufnr = bufnr})
                term.jump_previous_prompt()
            end, {buffer=true})
            vim.keymap.set({'n', 'x', 'o'}, ']l', function()
                -- local bufnr = vim.api.nvim_get_current_buf()
                -- term.jump_next_prompt({bufnr = bufnr})
                term.jump_next_prompt()
            end, {buffer=true})
        end)
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
vim.api.nvim_set_keymap('n', '<leader>qn', ':cnewer<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>qp', ':colder<CR>', {noremap = true, silent = true})


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
-- vim.api.nvim_set_keymap('n', '<leader>gfl', ":Git log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local -- %<CR>", {noremap = true, silent = true})


-- Git
vim.api.nvim_set_keymap('n', '<leader>gs', ':Neogit<CR>', {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>gS', [[<Cmd>:Git<CR>]], {silent=true})
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', {noremap = true, silent = true})
vim.keymap.set({'n'}, '<leader>gl', '<Cmd>DiffViewFileHistory %<CR>', {silent=true})
vim.keymap.set({'n'}, '<leader>gL', '<Cmd>DiffViewFileHistory<CR>', {silent=true})
vim.keymap.set({'n'}, '<leader>gg', "<Cmd>GBrowse<CR>", {silent = true})
vim.keymap.set({'n'}, '<leader>gd', "<Cmd>Gdiffsplit<CR>", {silent = true})
vim.keymap.set({'n'}, '<leader>gc', ":!gh pr create --fill --draft && gh pr view --web<CR>", {silent = true})
vim.keymap.set({'n'}, '<leader>gj', require('plugins.github').pr_checks, {}) -- "j" for jenkins
vim.keymap.set({'n'}, '<leader>gv', ":!gh pr view --web<CR>", {silent = true})


-- Debug (DAP)
vim.keymap.set({'n'}, '<leader>dc', function() require('dap').continue() end, {silent=true})
vim.keymap.set({'n'}, '<leader>db', function() require('dap').toggle_breakpoint() end, {silent=true})
vim.keymap.set({'n'}, '<leader>dn', function() require('dap').step_over() end, {silent=true})
vim.keymap.set({'n'}, '<leader>di', function() require('dap').step_into() end, {silent=true})
vim.keymap.set({'n'}, '<leader>do', function() require('dap').step_out() end, {silent=true})
vim.keymap.set({'n'}, '<leader>dt', function() require('dap').terminate() end, {silent=true})


-- Open / Org
vim.keymap.set({'n'}, '<leader>od', function() require('oil').open('~/Downloads') end, {silent=true})
vim.keymap.set({'n'}, '<leader>os', [[<Cmd>edit ~/.ssh/config<CR>]], {silent=true})
vim.keymap.set({'n'}, '<leader>oC', [[<Cmd>edit $ORG/capture.org<CR>]], {silent=true})
vim.keymap.set({'n'}, '<leader>O', [[<Cmd>tabedit $ORG/gtd.org<CR>]], {silent = true})


-- Config / Clipboard
-- vim.keymap.set({'n'}, '<leader>cc', function() require('plugins.project').open_project_tab('~/sandbox/nathanlc/dotfiles') end, {silent=true})
vim.keymap.set({'n'}, '<leader>cs', [[<Cmd>Lazy sync<CR>]], {silent=true})

vim.keymap.set({'n'}, '<leader>cl', function() require('plugins.clipboard').select_and_copy() end, {silent=true})
vim.keymap.set({'n'}, '<leader>ce', function() require('plugins.clipboard').edit() end, {silent=true})


-- File explorer
vim.keymap.set({"n"}, "<leader>-", [[<Cmd>Oil<CR>]], {silent=true})
-- See nvim/lua/plugins/oil.lua for oil keymaps


-- Manipulation of text
vim.keymap.set({'n'}, '<leader>ms', '<Cmd>TSJSplit<CR>', {silent=true})
vim.keymap.set({'n'}, '<leader>mS', function() require('treesj').split({ split = { recursive = true } }) end, {silent=true})
vim.keymap.set({'n'}, '<leader>mj', '<Cmd>TSJJoin<CR>', {silent=true})
vim.keymap.set({'n'}, [[<leader>m"]], [[<Cmd>s/'/"/g<CR><Esc>]], {silent=true})
vim.keymap.set({'n'}, [[<leader>m']], [[<Cmd>s/"/'/g<CR><Esc>]], {silent=true})
vim.keymap.set({'n'}, [[<leader>mt]], [[<Cmd>%s/ \+$//g<CR><Esc>]], {silent=true})
vim.keymap.set({'v'}, [[<leader>m"]], [[:s/\%V'/"/g<CR><Esc>]], {silent=true})
vim.keymap.set({'v'}, [[<leader>m"]], [[:s/\%V'/"/g<CR><Esc>]], {silent=true})


-- Insert text
vim.keymap.set({'n'}, '<leader>imm', [[oimethod<Plug>luasnip-expand-or-jump]], {silent=true})
vim.keymap.set({'n'}, '<leader>imp', [[<Cmd>lua require("nvim-treesitter-textobjects.move").goto_previous_start('@function.outer', 'textobjects')<CR>Oimethod<Plug>luasnip-expand-or-jump]], {silent=true})
vim.keymap.set({'n'}, '<leader>imn', [[<Cmd>lua require("nvim-treesitter-textobjects.move").goto_next_start('@function.outer', 'textobjects')<CR>Oimethod<Plug>luasnip-expand-or-jump]], {silent=true})
vim.keymap.set({'i'}, ';d', [[<C-r>=strftime('%Y-%m-%d')<CR>]], {silent=true})

-- Go to (Opener)
vim.keymap.set({'n'}, 'gx', require('open').open_cword, {silent=true})


-- Gcal
-- vim.keymap.set({'n'}, '<leader>aa', require('plugins.gcal').add, {silent=true})


-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('nathanlc', {clear=true}),
    callback = function(args)
        local bufopts = { silent = true, buffer = args.buf }
        -- -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', [[<Cmd>FzfLua lsp_definitions<CR>]], bufopts)
        vim.keymap.set('n', 'gD', [[<CMD>vsplit<CR><Cmd>FzfLua lsp_definitions<CR>]], bufopts)
        vim.keymap.set('n', 'gi', [[<Cmd>FzfLua lsp_implementations<CR>]], bufopts)
        vim.keymap.set('n', 'gr', [[<Cmd>FzfLua lsp_references<CR>]], bufopts)
        vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)
        -- -- vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        -- vim.keymap.set('n', 'H', vim.lsp.buf.signature_help, bufopts)
        -- -- vim.keymap.set('n', '<leader>Wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        -- -- vim.keymap.set('n', '<leader>Wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        -- -- vim.keymap.set('n', '<leader>Wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        vim.keymap.set('n', '<leader>xr', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, bufopts)
        -- -- vim.keymap.set("n", "<leader>I", [[<Cmd>lua print(vim.inspect(vim.lsp.get_clients({buffer=bufnr})[1].resolved_capabilities))<CR>]], bufopts)
        -- vim.keymap.set("n", "<leader>pjs", [[<Cmd>FzfLua lsp_workspace_symbols<CR>]], bufopts)
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
            vim.keymap.set('n', '<leader>pA', ':R<CR>', {silent=true, buffer=true})
        end)
    end
})

-- quickfix list
vim.api.nvim_create_autocmd('FileType', {
    group = nathan_lc_group,
    pattern = {"qf"},
    callback = function()
        vim.schedule(function()
            vim.keymap.set({'n'}, '<C-Space>', '<CR>:copen<CR>', {silent=true, buffer=true})
            vim.keymap.set({'n'}, '<leader>/', '<Cmd>packadd cfilter<CR>:Cfilter', {buffer=true})
        end)
    end
})

-- norg / neorg
-- vim.api.nvim_create_autocmd('FileType', {
--     group = nathan_lc_group,
--     pattern = {"norg"},
--     callback = function()
--         vim.schedule(function()
--             vim.keymap.set('n', '<C-Space>', '<Plug>(neorg.qol.todo-items.todo.task-cycle)', {silent=true, buffer=true})
--         end)
--     end
-- })


-- Treesitter textobjects
local select_pairs = {
  { "ib", "@block.inner" },
  { "ab", "@block.outer" },
  { "ac", "@class.outer" },
  { "ic", "@class.inner" },
  { "ii", "@conditional.inner" },
  { "ai", "@conditional.outer" },
  { "af", "@function.outer" },
  { "if", "@function.inner" },
  { "il", "@loop.inner" },
  { "al", "@loop.outer" },
  { "aa", "@parameter.outer" },
  { "ia", "@parameter.inner" },
}
for _, pair in ipairs(select_pairs) do
  local lhs, capture = pair[1], pair[2]
  vim.keymap.set({ "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
  end, { silent = true, desc = "select " .. capture })
end

local move_specs = {
  -- { lhs, capture, fn_name }
  { "[c", "@class.outer",       "goto_previous_start" },
  { "[f", "@function.outer",    "goto_previous_start" },
  { "[l", "@loop.outer",        "goto_previous_start" },
  { "[i", "@conditional.outer", "goto_previous_start" },
  { "[a", "@parameter.inner",   "goto_previous_start" },
  { "[b", "@block.inner",       "goto_previous_start" },

  { "[C", "@class.outer",       "goto_previous_end" },
  { "[F", "@function.outer",    "goto_previous_end" },
  { "[L", "@loop.outer",        "goto_previous_end" },
  { "[I", "@conditional.outer", "goto_previous_end" },
  { "[A", "@parameter.inner",   "goto_previous_end" },
  { "[B", "@block.inner",       "goto_previous_end" },

  { "]c", "@class.outer",       "goto_next_start" },
  { "]f", "@function.outer",    "goto_next_start" },
  { "]l", "@loop.outer",        "goto_next_start" },
  { "]i", "@conditional.outer", "goto_next_start" },
  { "]a", "@parameter.inner",   "goto_next_start" },
  { "]b", "@block.inner",       "goto_next_start" },

  { "]C", "@class.outer",       "goto_next_end" },
  { "]F", "@function.outer",    "goto_next_end" },
  { "]L", "@loop.outer",        "goto_next_end" },
  { "]I", "@conditional.outer", "goto_next_end" },
  { "]A", "@parameter.inner",   "goto_next_end" },
  { "]B", "@block.inner",       "goto_next_end" },
}
for _, spec in ipairs(move_specs) do
  local lhs, capture, fn_name = spec[1], spec[2], spec[3]
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.move")[fn_name](capture, "textobjects")
  end, { silent = true, desc = fn_name .. " " .. capture })
end

-- Repeatable f/F/t/T + ;/, that also repeat the last textobject move.
vim.keymap.set({ "n", "x", "o" }, ";", function()
  require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move()
end, { silent = true })
vim.keymap.set({ "n", "x", "o" }, ",", function()
  require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_opposite()
end, { silent = true })
vim.keymap.set({ "n", "x", "o" }, "f", function()
  return require("nvim-treesitter-textobjects.repeatable_move").builtin_f_expr()
end, { expr = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "F", function()
  return require("nvim-treesitter-textobjects.repeatable_move").builtin_F_expr()
end, { expr = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "t", function()
  return require("nvim-treesitter-textobjects.repeatable_move").builtin_t_expr()
end, { expr = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "T", function()
  return require("nvim-treesitter-textobjects.repeatable_move").builtin_T_expr()
end, { expr = true, silent = true })

