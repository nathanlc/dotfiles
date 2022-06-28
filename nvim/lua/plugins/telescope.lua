local telescope = require('telescope')

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "%.class",
        },
    },
    extensions = {
        project = {
            base_dirs = {
                '~/sandbox',
            },
        }
    }
})

telescope.load_extension('file_browser')
telescope.load_extension('project')
