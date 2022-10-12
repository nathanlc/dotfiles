require('options')

require('package-manager')

require('plugins.lsp-setup')
require('plugins.treesitter')
require('plugins.completion')
require('plugins.theme')
require('plugins.telescope')
require('plugins.nerdcommenter')
require('plugins.neogit')
require('plugins.orgmode')
require('plugins.leap')
require('plugins.snippet')
require('plugins.himalaya')
require('plugins.lualine')
require('plugins.indent_blankline')

require('mappings')

require('plugins.home').startup()
