local M = {}

local function oldFiles()
  local old_files = vim.v.oldfiles
  local files = table.unpack(old_files, 1, 6)
end

function M.home()
  local bufnr = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
    '',
    'Home',
    '',
    '',
    'Recent files:',
    ''
  })
end

return M
