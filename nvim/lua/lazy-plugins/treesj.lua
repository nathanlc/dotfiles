return {
	"Wansmer/treesj",
	config = function()
		local tsj = require('treesj')
		tsj.setup({
			use_default_keymaps = false,
			max_join_length = 999,
		})
	end
}
