local Window = require('utils.window')
local Table = require('utils.table')

local M = {}

local scratch_buf, scratch_win

function M.set_options(buf, opts)
  for k, v in pairs(opts) do
    vim.api.nvim_buf_set_option(buf, k, v)
  end
end

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
    scratch_win = Window.open_above()
  end
  if not scratch_buf then
    scratch_buf = create_scratch_buffer()
  end
  vim.api.nvim_set_current_win(scratch_win)
  vim.api.nvim_win_set_buf(scratch_win, scratch_buf)
end

function M.list()
  local all_buffers = vim.api.nvim_list_bufs()
  local valid_buffers = Table.filter(function (b)
    if b == 0 then
      return false
    end
    if vim.api.nvim_buf_get_name(b) == "" then
      return false
    end

    return vim.api.nvim_buf_is_loaded(b)
  end, all_buffers)

  return Table.reduce(function(nrNameMap, b)
    nrNameMap[b] = vim.api.nvim_buf_get_name(b)

    return nrNameMap
  end, {}, valid_buffers)
end

return M
