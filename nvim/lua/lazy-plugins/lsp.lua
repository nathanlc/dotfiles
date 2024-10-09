return {
	"williamboman/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-jdtls",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		-- "WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				-- "clang-format",
				-- "clangd",
				-- "elm-format",
				-- "elm-language-server",
				-- "elmls",
				-- "eslint-lsp",
				"gopls",
				-- "intelephense",
				"jdtls",
				"lua_ls",
				"pyright",
				"ruby_lsp",
				-- "rust-analyzer",
				"sqlls",
				"ts_ls",
			},
			handlers = {
				function(server)
					require("lspconfig")[server].setup({
						capabilities = require("plugins.lsp-capabilities").get(),
					})
				end,
				["jdtls"] = function() end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = require("plugins.lsp-capabilities").get(),
						  settings = {
							Lua = {
								runtime = {
									version = 'LuaJIT',
								},
								diagnostics = {
									globals = {
										'vim',
										'hs', -- hammerspoon
									},
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
								},
							},
						},
					})
				end
			},
		})
	end,
}
