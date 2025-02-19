return {
	"stevearc/overseer.nvim",
	config = function()
		require('overseer').setup({
			log = {
				{
					type = "file",
					filename = "overseer.log",
					level = vim.log.levels.DEBUG, -- or TRACE for max verbosity
				},
			},
			task_list = {
				min_width = {60, 0.2}
			},
			templates = {
				"builtin",
				"user.gradle_test_file",
				"user.gradle_test_project",
				"user.gradle_check",
				"user.kl_test_file",
				"user.kl_test_project",
				"user.kl_lint",
				"user.azr_test_file",
			},
		})
	end
}
