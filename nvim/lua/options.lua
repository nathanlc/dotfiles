local autocmd = require('utils.autocmd')

vim.opt.path = vim.opt.path - { '/usr/include' } + { '**' }

vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

vim.opt.shortmess = 'atOI'

vim.opt.report = 0

-- vim.opt.listchars = {
--     tab: '→ ',
--     eol: '↵',
--     trail: '·',
--     extends: '↷',
--     precedes: '↶',
-- }


vim.opt.clipboard = 'unnamed'

vim.opt.relativenumber = true

vim.opt.hidden = true

vim.opt.foldmethod = 'expr'
vim.opt.foldlevel = 99

vim.opt.scrolloff = 1

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- Those should be handled via sleuth
-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.smarttab = true

vim.o.breakindent = true


-- Decrease update time
vim.o.updatetime = 450
vim.o.timeout = true
vim.o.timeoutlen = 500

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.netrw_bufsettings = {
  'nomodifiable',
  'nomodified',
  'relativenumber',
  'nowrap',
  'readonly',
}
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

if vim.fn.executable('rg') then
  vim.opt.grepprg = 'rg --vimgrep --smart-case'
  vim.opt.grepformat = '%f:%l:%c:%m'
end

vim.opt.laststatus = 0

-- scrollback in term buffer
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('nathanlc:TermOpen-options', {clear=true}),
    pattern = {"*"},
    callback = function()
      vim.opt_local.scrollback = 100000
    end
})

autocmd.create_augroup({
    { 'QuickFixCmdPost', '[^l]*', 'cwindow' },
    { 'QuickFixCmdPost', 'l*', 'lwindow' }
}, 'grep')

autocmd.create_augroup({
    { 'FileType', 'qf', 'setlocal', 'cursorline' },
    { 'FileType', 'qf', 'setlocal', 'number' },
    { 'FileType', 'qf', 'setlocal', 'norelativenumber' },
    { 'FileType', 'qf', 'nnoremap', '<C-Space>', '<CR>:copen<CR>' },
}, 'quickfix')

autocmd.create_augroup({
    { 'FileType' , 'org', 'setlocal', 'conceallevel=2' },
    { 'FileType' , 'org', 'setlocal', 'concealcursor=nc' }
}, 'org')
