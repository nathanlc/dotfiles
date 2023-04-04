local Window = require('utils.window')

local M = {}

function M.open_small_term()
  vim.api.nvim_command('split term://bash')
  Window.make_small()
end

function M.run_in_term(command)
  M.open_small_term()
  local channel_id = vim.opt_local.channel:get()
  vim.fn.chansend(channel_id, command .. '\n')
  vim.api.nvim_win_set_cursor(0, {vim.api.nvim_buf_line_count(0), 0})
  return vim.api.nvim_get_current_buf()
end

return M
