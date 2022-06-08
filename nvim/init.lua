require('options')

-- Install package manager paq-nvim
-- git clone --depth=1 https://github.com/savq/paq-nvim.git "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
-- Checkout for documentation https://github.com/savq/paq-nvim
-- PaqInstall: Install all packages listed in your configuration.
-- PaqUpdate: Update all packages already on your system (it won't implicitly install them).
-- PaqClean: Remove all packages (in Paq's directory) that aren't listed on your configuration.
require('package-manager')

require('plugins.lspconfig')
require('plugins.treesitter')
require('plugins.compe')
require('plugins.theme')
require('plugins.telescope')
require('plugins.nerdcommenter')
require('plugins.neogit')
require('plugins.orgmode')

require('mappings')