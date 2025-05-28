return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		"RRethy/nvim-treesitter-endwise",
		'windwp/nvim-ts-autotag',
	},
	build = function()
		vim.cmd("TSUpdate")
	end,
	config = function()
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				"bash",
				"elm",
				"go",
				"java",
				"javascript",
				"jsdoc",
				"lua",
				"markdown",
				"php",
				"python",
				"ruby",
				"rust",
				"typescript",
				"vimdoc",
				"zig",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = { "phpdoc" },
			highlight = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>v", -- set to `false` to disable one of the mappings
					node_incremental = "+",
					-- scope_incremental = "grc",
					node_decremental = "-",
				},
			},
			indent = {
				enable = true,
			},
			matchup = {
				enable = true,
				disable = {}
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						['ib'] = '@block.inner',
						['ab'] = '@block.outer',
						['ac'] = '@class.outer',
						['ic'] = '@class.inner',
						['ii'] = '@conditional.inner',
						['ai'] = '@conditional.outer',
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['il'] = '@loop.inner',
						['al'] = '@loop.outer',
						['aa'] = '@parameter.outer',
						['ia'] = '@parameter.inner',
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_previous_start = {
						['[c'] = '@class.outer',
						['[f'] = '@function.outer',
						['[l'] = '@loop.outer',
						['[i'] = '@conditional.outer',
						['[a'] = '@parameter.inner',
						['[b'] = '@block.inner',
					},
					goto_next_start = {
						[']c'] = '@class.outer',
						[']f'] = '@function.outer',
						[']l'] = '@loop.outer',
						[']i'] = '@conditional.outer',
						[']a'] = '@parameter.inner',
						[']b'] = '@block.inner',
					},
				}
			},
			autotag = {
				enable = true,
			},
			endwise = {
				enable = true,
			},
		})

		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
	end
}
