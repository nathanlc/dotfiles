-- nvim-treesitter `main` branch (rewrite) for nvim 0.12.
-- The legacy `require('nvim-treesitter.configs').setup({...})` API is gone.
-- See https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
-- Keymaps live in plugin/mappings.lua under "Treesitter textobjects".

local ensure_installed = {
	"bash",
	"css",
	"scss",
	"elm",
	"go",
	"html",
	"java",
	"javascript",
	"jsdoc",
	"lua",
	"markdown",
	"php",
	"python",
	"ruby",
	"rust",
	"tsx",
	"typescript",
	"vimdoc",
	"zig",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- main branch does NOT support lazy-loading
	build = ":TSUpdate",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
		"nvim-treesitter/nvim-treesitter-context",
		"RRethy/nvim-treesitter-endwise",
		{ "windwp/nvim-ts-autotag", branch = "main" },
	},
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		require("nvim-treesitter").install(ensure_installed):wait(300000)

		-- Highlighting / folds / indent are no longer enabled by the plugin;
		-- they must be turned on per-buffer.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("nathanlc_treesitter", { clear = true }),
			callback = function(args)
				local bufnr = args.buf
				local ft = vim.bo[bufnr].filetype
				local lang = vim.treesitter.language.get_lang(ft) or ft
				if not lang or lang == "" then return end

				local ok = pcall(vim.treesitter.start, bufnr, lang)
				if not ok then return end

				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
				vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		require("treesitter-context").setup({
			multiline_threshold = 15,
		})

		require("nvim-ts-autotag").setup()
	end,
}
