return {
	"stevearc/overseer.nvim",
	config = function()
		require('overseer').setup({
			-- log = {
			-- 	{
			-- 		type = "file",
			-- 		filename = "overseer.log",
			-- 		level = vim.log.levels.DEBUG, -- or TRACE for max verbosity
			-- 	},
			-- },
			-- task_list = {
			-- 	min_width = {60, 0.2}
			-- },
		})
	end
}
