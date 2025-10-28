return {
	{
		'saghen/blink.cmp',
		dependencies = {
			'folke/lazydev.nvim',
			{
				'L3MON4D3/LuaSnip',
				version = 'v2.*',
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require('luasnip').filetype_extend("ruby", {"rails"})
				end,
			},
		},

		version = '*',

		opts = {
			enabled = function()
				local enabled = true
				if vim.bo.filetype == 'TelescopePrompt' then enabled = false end
				if vim.bo.buftype == 'prompt' then enabled = false end
				return enabled
			end,

			keymap = { preset = 'default' },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			snippets = {
				preset = 'luasnip',
				expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
				active = function(filter)
					if filter and filter.direction then
						return require('luasnip').jumpable(filter.direction)
					end
					return require('luasnip').in_snippet()
				end,
				jump = function(direction) require('luasnip').jump(direction) end,
			},

			sources = {
				default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				}
				-- optionally disable cmdline completions
				-- cmdline = {},
			},

			signature = { enabled = true }
		},

		opts_extend = { "sources.default" }
	},
}
