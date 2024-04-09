require('options')

require('package-manager')

require('plugins.lsp-setup')
require('plugins.treesitter')
require('plugins.debugger')
require('plugins.completion')
require('plugins.theme')
require('plugins.telescope')
require('plugins.neogit')
require('plugins.orgmode')
require('plugins.leap')
require('plugins.snippet')
require('plugins.himalaya')
require('plugins.lualine')
require('plugins.indent_blankline')
require('plugins.comment')
require('plugins.surround')
require('plugins.copilot')
require('plugins.opener')
require('plugins.rust-tools')
require('plugins.flutter-tools')
require('plugins.task-runner')
require('plugins.oil')
require('plugins.term')
require('plugins.undotree')
require('plugins.harpoon')

-- require('plugins.noice')

require('mappings')

require('plugins.neovide')

-- TODO: move to a plugin or something
vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait'

require('plugins.home').startup()
