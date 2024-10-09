return {
	"zbirenbaum/copilot.lua",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<Tab>",
					next = "<C-f>",
					prev = "<C-b>",
				}
			}
		})
	end,
}
