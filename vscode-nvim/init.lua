require('options')

require('package-manager')

require('plugins.comment')

-- Mappings
vim.keymap.set({'n'}, '<Space>', '', {})
vim.g.mapleader = ' '

-- Moving
-- Moving between splits and panes is already handled in VScode's keybindings.json


-- Windows
vim.keymap.set({'n'}, '<leader>wv', '<Cmd>call VSCodeCall("workbench.action.splitEditorRight")<CR>', {})
vim.keymap.set({'n'}, '<leader>wV', '<Cmd>call VSCodeCall("workbench.action.splitEditorLeft")<CR>', {})
vim.keymap.set({'n'}, '<leader>ws', '<Cmd>call VSCodeCall("workbench.action.splitEditorDown")<CR>', {})
vim.keymap.set({'n'}, '<leader>wS', '<Cmd>call VSCodeCall("workbench.action.splitEditorUp")<CR>', {})
vim.keymap.set({'n'}, '<leader>wd', '<Cmd>call VSCodeCall("workbench.action.closeActiveEditor")<CR>', {})
vim.keymap.set({'n'}, '<leader>w=', '<Cmd>call VSCodeCall("workbench.action.evenEditorWidths")<CR>', {})
vim.keymap.set({'n'}, '<leader>wo', '<Cmd>call VSCodeCall("workbench.action.joinAllGroups")<CR>', {})


-- Files
vim.keymap.set({'n'}, '<leader>fl', '<Cmd>call VSCodeCall("workbench.action.quickOpen")<CR>', {})

-- Magit
vim.keymap.set({'n'}, '<leader>gs', '<Cmd>call VSCodeCall("magit.status")<CR>', {})


-- Problems
vim.keymap.set({'n'}, '<leader>el', '<Cmd>call VSCodeCall("workbench.actions.view.problems")<CR>', {})
vim.keymap.set({'n'}, '<leader>en', '<Cmd>call VSCodeCall("editor.action.marker.next")<CR>', {})
vim.keymap.set({'n'}, '<leader>ep', '<Cmd>call VSCodeCall("editor.action.marker.prev")<CR>', {})


-- Search
vim.keymap.set({'n'}, '<leader>sg', '<Cmd>call VSCodeCall("workbench.action.findInFiles")<CR>', {})


-- Jumps
vim.keymap.set({'n'}, '<leader>js', '<Cmd>call VSCodeCall("workbench.action.gotoSymbol")<CR>', {})


-- Terminal
vim.keymap.set({'n'}, '<leader>"t', '<Cmd>call VSCodeCall("workbench.action.terminal.toggleTerminal")<CR>', {})
vim.keymap.set({'n'}, '<leader>"n', '<Cmd>call VSCodeCall("workbench.action.terminal.new")<CR>', {})
vim.keymap.set({'n'}, '<leader>"j', '<Cmd>call VSCodeCall("workbench.action.terminal.focusNext")<CR>', {})
vim.keymap.set({'n'}, '<leader>"k', '<Cmd>call VSCodeCall("workbench.action.terminal.focusPrevious")<CR>', {})


-- Test
vim.keymap.set({'n'}, '<leader>tf', '<Cmd>call VSCodeCall("workbench.action.tasks.runTask", "Test file")<CR>', {})


-- Project
vim.keymap.set({'n'}, '<leader>pc', '<Cmd>call VSCodeCall("workbench.action.tasks.runTask", "Console")<CR>', {})
vim.keymap.set({'n'}, '<leader>pr', '<Cmd>call VSCodeCall("workbench.action.tasks.runTask", "Repl")<CR>', {})


-- Worspaces
vim.keymap.set({'n'}, '<leader>pl', '<Cmd>call VSCodeCall("workbench.action.openRecent")<CR>', {})
