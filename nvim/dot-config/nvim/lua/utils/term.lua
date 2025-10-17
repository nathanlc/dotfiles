local M = {}

function M.open_small_term(shell)
  shell = shell or 'zsh'
  vim.api.nvim_command('split term://' .. shell)
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end

local function run_command(command)
  local channel_id = vim.opt_local.channel:get()
  vim.fn.chansend(channel_id, command .. '\n')
  vim.api.nvim_win_set_cursor(0, {vim.api.nvim_buf_line_count(0), 0})
  return vim.api.nvim_get_current_buf()
end

function M.run_in_term(command)
  M.open_small_term('zsh')
  return run_command(command)
end

function M.run_in_term_current(command)
  vim.api.nvim_command('edit term://zsh')
  return run_command(command)
end

return M
