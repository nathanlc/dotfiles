local utils = require('utils')

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

vim.opt.relativenumber = true

vim.opt.hidden = true

vim.opt.foldmethod = 'expr'
vim.opt.foldlevel = 99

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.netrw_bufsettings = {
  'nomodifiable',
  'nomodified',
  'relativenumber',
  'nobuflisted',
  'nowrap',
  'readonly',
}
vim.g.netrw_liststyle = 3

if vim.fn.executable('rg') then
  vim.opt.grepprg = 'rg --vimgrep --smart-case'
  vim.opt.grepformat = '%f:%l:%c:%m'
end

utils.create_augroup({
    { 'QuickFixCmdPost', '[^l]*', 'cwindow' },
    { 'QuickFixCmdPost', 'l*', 'lwindow' }
}, 'grep')

utils.create_augroup({
    { 'FileType', 'qf', 'setlocal', 'cursorline' },
    { 'FileType', 'qf', 'setlocal', 'number' },
    { 'FileType', 'qf', 'setlocal', 'norelativenumber' },
}, 'quickfix')