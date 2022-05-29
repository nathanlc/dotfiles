local telescope = require('telescope')

telescope.setup({
    -- defaults = {
    --     layout_strategy = 'horizontal',
    --     width = 0.9,
    -- }
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
