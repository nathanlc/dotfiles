return {
	"ofirgall/open.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ofirgall/open-jira.nvim",
	},
	config = function()
		require('open').setup({})
		require('open-jira').setup {
			url = 'https://glooko.atlassian.net/browse/'
		}
	end,
}
