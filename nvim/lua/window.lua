local M = {}

function M.open_above()
    local win
    vim.api.nvim_command('leftabove new')
    win = vim.api.nvim_get_current_win()

    return win
end

return M
