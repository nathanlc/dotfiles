return {
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	config = function()
	-- 		require('everforest').setup({
	-- 			background = "hard",
	-- 			on_highlights = function(hl, _)
	-- 				-- The default highlights for TSBoolean is linked to `Purple` which is fg
	-- 				-- purple and bg none. If we want to just add a bold style to the existing,
	-- 				-- we need to have the existing *and* the bold style. (We could link to
	-- 				-- `PurpleBold` here otherwise.)
	-- 				hl.Normal = { fg = "#d3c6aa", bg = "NvimDarkGrey2" }
	-- 			end,
	-- 		})
	-- 		vim.cmd([[colorscheme everforest]])
	-- 	end
	-- },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			vim.cmd([[hi Directory ctermfg=14 guifg=#F8C8DC]])
			vim.cmd([[hi MoreMsg ctermfg=14 guifg=#F8C8DC]])
			vim.cmd([[hi Question ctermfg=14 guifg=#F8C8DC]])
			vim.cmd([[hi SpellRare cterm=undercurl gui=undercurl guisp=#F8C8DC]])
			vim.cmd([[hi QuickFixLine ctermfg=14 guifg=#F8C8DC]])
			vim.cmd([[hi Special ctermfg=14 guifg=#F8C8DC]])
			vim.cmd([[hi DiagnosticInfo ctermfg=14 guifg=#F8C8DC]])
			vim.cmd([[hi Function ctermfg=14 guifg=#F8C8DC]])
			vim.cmd([[hi Changed ctermfg=14 guifg=#F8C8DC]])
			vim.cmd([[hi DiagnosticUnderlineInfo cterm=underline gui=underline guisp=#F8C8DC]])
			vim.cmd([[hi CmpItemKindDefault guifg=#F8C8DC]])

			local c = {bg = "NvimDarkGrey2", fg = "NvimLightGrey2"}
			local b = c

			local theme = {
				normal = {
					a = {bg = "NvimLightGrey2", fg = "NvimDarkGrey1", gui = 'bold'},
					b = b,
					c = c,
				},
				insert = {
					a = {bg = "NvimLightYellow", fg = "NvimDarkGrey1", gui = 'bold'},
					b = b,
					c = c,
				},
				visual = {
					a = {bg = "NvimLightRed", fg = "NvimDarkGrey1", gui = 'bold'},
					b = b,
					c = c,
				},
				replace = {
					a = {bg = "NvimLightCyan", fg = "NvimDarkGrey1", gui = 'bold'},
					b = b,
					c = c,
				},
				command = {
					a = {bg = "NvimLightGreen", fg = "NvimDarkGrey1", gui = 'bold'},
					b = b,
					c = c,
				},
				inactive = {
					a = {bg = "NvimLightGrey4", fg = "NvimDarkGrey1", gui = 'bold'},
					b = b,
					c = c,
				}
			}

			local color_inactive = {fg = "NvimLightGrey4"}

			local filepath = function(color)
				return {
					'%f %m',
					color = color
				}
			end
			local filetype = function(color)
				return {
					'filetype',
					separator = '',
					icon_only = true,
					padding = { left = 1, right = 0 },
					color = color
				}
			end

			require('lualine').setup({
				options = {
					theme = theme,
					section_separators = { left = '', right = '' },
					component_separators = { left = '', right = '' },
				},
				tabline = {
					lualine_a = {
						{
							'tabs',
							mode = 2,
							max_length = vim.o.columns,
							tabs_color = {
								-- active = { bg = '' },
								inactive = 'lualine_c_inactive'
							}
						},
					},
					lualine_b = {},
					-- lualine_c = { project_terms_count, 'overseer' },
					lualine_c = { 'overseer' },
					lualine_x = {},
					lualine_y = {},
					lualine_z = { 'branch' },
				},
				sections = {
					lualine_a = { { 'mode' , fmt = function(str) return str:sub(1,1) end } },
					lualine_b = {},
					lualine_c = { filetype({}), filepath({}), 'diagnostics' },
					lualine_x = { 'selectioncount', 'searchcount' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { filetype(color_inactive), filepath(color_inactive) },
					-- lualine_c = { filetype({}), filepath({}) },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {},
				},
				-- winbar = {
				--   lualine_a = {},
				--   lualine_b = {},
				--   lualine_c = { 'diagnostics', treesitter_context },
				--   lualine_x = {},
				--   lualine_y = {},
				--   lualine_z = {}
				-- },
				-- inactive_winbar = {
				--   lualine_a = {},
				--   lualine_b = {},
				--   lualine_c = {},
				--   lualine_x = { file_type, 'filename' },
				--   lualine_y = {},
				--   lualine_z = {}
				-- },
			})
		end,
	},
}
