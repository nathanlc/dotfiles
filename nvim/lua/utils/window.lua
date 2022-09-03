local M = {}

function M.open_above()
    local win
    vim.api.nvim_command('leftabove new')
    win = vim.api.nvim_get_current_win()

    return win
end

function M.screen_size()
    return {
        width = vim.api.nvim_get_option('columns'),
        height = vim.api.nvim_get_option('lines'),
    }
end

function M.make_small()
    vim.api.nvim_command('resize 18')
end

return M