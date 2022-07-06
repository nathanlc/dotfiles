local window = require('window')

local M = {}

local scratch_buf, scratch_win

local function create_scratch_buffer()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_name(buf, 'scratch')
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_option(buf, 'swapfile', false)

    return buf
end

function M.scratch()
    if (not scratch_win) or (not vim.api.nvim_win_is_valid(scratch_win)) then
        scratch_win = window.open_above()
    end
    if not scratch_buf then
        scratch_buf = create_scratch_buffer()
    end
    vim.api.nvim_set_current_win(scratch_win)
    vim.api.nvim_win_set_buf(scratch_win, scratch_buf)
end

return M
