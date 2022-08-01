local telescope = require('telescope')

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "%.class",
        },
        cache_picker = {
            num_pickers = 10,
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

telescope.load_extension('fzy_native')
