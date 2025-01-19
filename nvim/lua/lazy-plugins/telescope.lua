return {
    "nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		{"nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require('telescope')
		local actions = require("telescope.actions")

		telescope.setup({
			wrap_results = true,
			defaults = {
				mappings = {
					i = {
						["<A-b>"] = { "<S-Left>", type = "command" },
						["<A-f>"] = { "<S-Right>", type = "command" },
						["<C-b>"] = { "<Left>", type = "command" },
						["<C-d>"] = { "<Del>", type = "command" },
						["<C-f>"] = { "<Right>", type = "command" },
						['<C-S-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
						['<C-c>'] = require('telescope.actions').close,
						['<C-g>'] = require('telescope.actions').close,
						['<C-j>'] = require('telescope.actions').preview_scrolling_down,
						['<C-k>'] = require('telescope.actions').preview_scrolling_up,
						['<C-o>'] = require('telescope.actions.layout').toggle_preview,
					},
					n = {
						['<C-S-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
						['<C-c>'] = require('telescope.actions').close,
						['<C-g>'] = require('telescope.actions').close,
						['<C-n>'] = require('telescope.actions').move_selection_next,
						['<C-p>'] = require('telescope.actions').move_selection_previous,
						['<C-o>'] = require('telescope.actions.layout').toggle_preview,
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
					},
				},
				preview = {
					hide_on_startup = true,
				},
			},
			pickers = {
				buffers = {
					theme = "ivy",
				},
				find_files = {
					theme = "ivy",
				},
				lsp_references = {
				  theme = "ivy",
				},
				oldfiles = {
				  theme = "ivy",
				},
			}
		})

		telescope.load_extension('fzf')

		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function(args)
				-- if args.data.filetype ~= "help" then
				-- 	vim.wo.number = true
				-- elseif args.data.bufname:match("*.csv") then
				-- 	vim.wo.wrap = false
				-- end
				vim.wo.wrap = true
			end,
		})
	end,
}
