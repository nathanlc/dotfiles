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
	-- {
	-- 	-- "hrsh7th/nvim-cmp",
	-- 	"iguanacucumber/magazine.nvim",
	-- 	name = "nvim-cmp",
	-- 	lazy = false,
	-- 	priority = 100,
	-- 	dependencies = {
	-- 		"onsails/lspkind.nvim",
	-- 		-- "hrsh7th/cmp-nvim-lsp",
	-- 		-- "hrsh7th/cmp-path",
	-- 		-- "hrsh7th/cmp-buffer",
	-- 		-- "hrsh7th/cmp-cmdline",
	-- 		"dmitmel/cmp-cmdline-history",
	-- 		"https://codeberg.org/FelipeLema/cmp-async-path",
	-- 		{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
	-- 		{ "iguanacucumber/mag-buffer",   name = "cmp-buffer" },
	-- 		{ "iguanacucumber/mag-cmdline",  name = "cmp-cmdline" },
	-- 		-- { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
	-- 		{
	-- 			"L3MON4D3/LuaSnip",
	-- 			version = "v2.*",
	-- 			build = "make install_jsregexp",
	-- 			dependencies = {
	-- 				"rafamadriz/friendly-snippets",
	-- 			},
	-- 			config = function()
	-- 				require("luasnip.loaders.from_vscode").lazy_load()
	-- 			end
	-- 		},
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 	},
	-- 	config = function()
	-- 		local cmp = require('cmp')
	-- 		require('lspkind').init()
	-- 		local ls = require("luasnip")
	--
	-- 		ls.filetype_extend('ruby', { 'rails' })
	-- 		ls.filetype_extend('javascript', { 'javascriptreact' })
	-- 		require('luasnip.loaders.from_vscode').lazy_load()
	--
	-- 		cmp.setup({
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					ls.lsp_expand(args.body)
	-- 				end,
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				['<C-u>'] = cmp.mapping.scroll_docs(-4),
	-- 				['<C-d>'] = cmp.mapping.scroll_docs(4),
	-- 				['<C-Space>'] = cmp.mapping.complete(),
	-- 				['<C-g>'] = cmp.mapping.abort(),
	-- 				['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 				['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 				['<C-y>'] = cmp.mapping(
	-- 					cmp.mapping.confirm {
	-- 						behavior = cmp.ConfirmBehavior.Insert,
	-- 						select = true,
	-- 					},
	-- 					{ "i", "c" }
	-- 				),
	-- 			}),
	-- 			sources = {
	-- 				{ name = 'nvim_lsp' },
	-- 				{ name = 'nvim_lua' },
	-- 				{ name = 'luasnip' },
	-- 				{ name = 'buffer' },
	-- 				{ name = 'orgmode' },
	-- 			},
	-- 		})
	--
	-- 		ls.config.set_config({
	-- 			history = false,
	-- 			updateevents = "TextChanged,TextChangedI",
	-- 		})
	--
	-- 		for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
	-- 			loadfile(ft_path)()
	-- 		end
	--
	-- 		vim.keymap.set({ "i" }, "<C-i>", function()
	-- 			ls.expand_or_jump()
	-- 		end, { silent = true })
	--
	-- 		vim.keymap.set({ "i", "s" }, "<C-j>", function()
	-- 			if ls.expand_or_jumpable() then
	-- 				ls.expand_or_jump()
	-- 			end
	-- 		end, { silent = true })
	--
	-- 		vim.keymap.set({ "i", "s" }, "<C-k>", function()
	-- 			if ls.jumpable(-1) then
	-- 				ls.jump(-1)
	-- 			end
	-- 		end, { silent = true })
	--
	-- 		cmp.setup.cmdline({ '/', '?' }, {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = {
	-- 				{ name = 'buffer' }
	-- 			}
	-- 		})
	--
	-- 		cmp.setup.cmdline(':', {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = cmp.config.sources(
	-- 				{
	-- 					{
	-- 						name = 'async_path',
	-- 					},
	-- 				}
	-- 			)
	-- 		})
	--
	-- 		-- cmp.setup.cmdline(':', {
	-- 		--   mapping = cmp.mapping.preset.cmdline(),
	-- 		--   sources = cmp.config.source({
	-- 		--     { name = 'path' }
	-- 		--   }, {
	-- 		--     { name = 'cmdline' }
	-- 		--   }),
	-- 		--   matching = { disallow_symbol_nonprefix_matching = false }
	-- 		-- })
	-- 	end,
	-- },
}
