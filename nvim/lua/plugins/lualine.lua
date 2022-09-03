-- local function filePath()
--   return vim.fn.expand('%')
-- end
--
local filePath = '%f %m'

require('lualine').setup({
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { filePath },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filePath },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
})
