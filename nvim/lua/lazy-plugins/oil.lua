return {
	"stevearc/oil.nvim",
	config = function()
		require('oil').setup({
			delete_to_trash = true,
			keymaps = {
				["<leader><C-v>"] = "actions.select_vsplit",
				["<leader><C-s>"] = "actions.select_split",
				["<leader>."] = "actions.open_terminal",
				["<C-s>"] = "<CMD>write<CR>",
				["<C-r>"] = "actions.refresh",
				["_"] = "_",
				["H"] = "actions.open_cwd",
			},
			view_options = {
				show_hidden = true,
			}
		})
	end,
}
