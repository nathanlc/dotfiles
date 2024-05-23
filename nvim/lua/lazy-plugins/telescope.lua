return {
    "nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		{"nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require('telescope')

		telescope.setup({
			wrap_results = true,
			defaults = {
				mappings = {
					i = {
						["<A-f>"] = { "<S-Right>", type = "command" },
						["<C-f>"] = { "<Right>", type = "command" },
						["<C-d>"] = { "<Del>", type = "command" },
					},
				},
				file_ignore_patterns = {
					"%.class",
					"^.git/",
				},
				cache_picker = {
				  num_pickers = 20,
				},
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						height = 0.95,
						width = 0.95,
					}
				}
			},
			pickers = {
				-- lsp_references = {
				--   theme = "cursor"
				-- }
			}
		})

		telescope.load_extension('fzf')
	end,
}
