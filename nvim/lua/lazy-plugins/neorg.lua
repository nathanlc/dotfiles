return {
	"nvim-neorg/neorg",
	lazy = false,
	version = "*",
	config = function ()
		require('neorg').setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							neorg = "~/Library/CloudStorage/Dropbox/neorg"
						},
						default_workspace = "neorg",
					}
				}
			}
		})
	end
}
