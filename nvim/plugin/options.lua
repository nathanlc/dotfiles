local autocmd = require('utils.autocmd')

vim.opt.path = vim.opt.path - { '/usr/include' } + { '**' }

vim.opt.colorcolumn = ""
vim.cmd([[highlight ColorColumn ctermbg=darkgrey guibg='#222222']])

vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

vim.opt.completeopt = {"menu", "menuone", "noselect" }

vim.opt.shortmess = 'atOISc'
vim.opt.showmode = false

vim.opt.shada._value = "!,'500,<50,s10,h"

vim.opt.report = 0

vim.opt.listchars = {
    tab = '  ',
    trail = '~',
}
vim.opt.list = true

vim.opt.clipboard = 'unnamed'

vim.opt.relativenumber = true

vim.opt.hidden = true

-- Folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ''
vim.opt.fillchars = 'fold: '
vim.opt.foldlevel = 99
-- 

vim.opt.scrolloff = 1

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Those should be handled via sleuth
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.smarttab = true

vim.o.breakindent = true


-- Preview commands
vim.o.inccommand = 'split'

vim.o.updatetime = 450

vim.opt.splitright = true
vim.opt.splitbelow = true

-- vim.g.netrw_bufsettings = {
--   'nomodifiable',
--   'nomodified',
--   'relativenumber',
--   'nowrap',
--   'readonly',
-- }
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_banner = 0

if vim.fn.executable('rg') then
  vim.opt.grepprg = 'rg --vimgrep --smart-case'
  vim.opt.grepformat = '%f:%l:%c:%m'
end

vim.opt.shell = '/bin/zsh'

-- scrollback in term buffer
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('nathanlc:TermOpen-options', {clear=true}),
    pattern = {"*"},
    callback = function()
      vim.opt_local.scrollback = 100000
    end
})


-- quickfix start
-- From https://github.com/kevinhwang91/nvim-bqf?tab=readme-ov-file#customize-quickfix-window-easter-egg
-- function _G.qftf(info)
--     local items
--     local ret = {}
--     -- The name of item in list is based on the directory of quickfix window.
--     -- Change the directory for quickfix window make the name of item shorter.
--     -- It's a good opportunity to change current directory in quickfixtextfunc :)
--     --
--     -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
--     -- local root = getRootByAlterBufnr(alterBufnr)
--     -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
--     --
--     if info.quickfix == 1 then
--         items = vim.fn.getqflist({id = info.id, items = 0}).items
--     else
--         items = vim.fn.getloclist(info.winid, {id = info.id, items = 0}).items
--     end
--     local limit = 50
--     local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
--     local validFmt = '%s │%5d:%-3d│%s %s'
--     for i = info.start_idx, info.end_idx do
--         local e = items[i]
--         local fname = ''
--         local str
--         if e.valid == 1 then
--             if e.bufnr > 0 then
--                 fname = vim.fn.bufname(e.bufnr)
--                 if fname == '' then
--                     fname = '[No Name]'
--                 else
--                     fname = fname:gsub('^' .. vim.env.HOME, '~')
--                 end
--                 -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
--                 if #fname <= limit then
--                     fname = fnameFmt1:format(fname)
--                 else
--                     fname = fnameFmt2:format(fname:sub(1 - limit))
--                 end
--             end
--             local lnum = e.lnum > 99999 and -1 or e.lnum
--             local col = e.col > 999 and -1 or e.col
--             local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
--             str = validFmt:format(fname, lnum, col, qtype, e.text)
--         else
--             str = e.text
--         end
--         table.insert(ret, str)
--     end
--     return ret
-- end

-- vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
-- quickfix end

vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait'

autocmd.create_augroup({
    { 'QuickFixCmdPost', '[^l]*', 'cwindow' },
    { 'QuickFixCmdPost', 'l*', 'lwindow' }
}, 'grep')

autocmd.create_augroup({
    { 'FileType', 'qf', 'setlocal', 'cursorline' },
    { 'FileType', 'qf', 'setlocal', 'number' },
    { 'FileType', 'qf', 'setlocal', 'norelativenumber' },
}, 'quickfix')

-- autocmd.create_augroup({
--     { 'FileType' , 'org', 'setlocal', 'conceallevel=2' },
--     { 'FileType' , 'org', 'setlocal', 'concealcursor=nc' }
-- }, 'org')
