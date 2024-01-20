-- local project = require('plugins.project.project')

-- local function project_terms_count()
--   local count = project.project_terms_count()
--   return ' ' .. count
-- end
-- local ts = require('nvim-treesitter')
-- local function treesitter_context()
--   return ts.statusline({
--     separator = " > ",
--   })
-- end

local filepath = '%f %m'
local filetype = { 'filetype', separator = '', icon_only = true, padding = { left = 1, right = 0 } }

local theme = require('lualine.themes.everforest')
theme.normal.c.fg = '#abb2bf'

require('lualine').setup({
  options = {
    theme = theme,
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  tabline = {
    lualine_a = { { 'tabs', mode = 2, max_length = vim.o.columns, use_mode_colors = true } },
    lualine_b = { 'branch' },
    -- lualine_c = { project_terms_count, 'overseer' },
    lualine_c = { 'overseer' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  sections = {
    lualine_a = { { 'mode' , fmt = function(str) return str:sub(1,1) end } },
    lualine_b = {},
    lualine_c = { filetype, filepath, 'diagnostics' },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filetype, filepath },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  -- winbar = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = { 'diagnostics', treesitter_context },
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = {}
  -- },
  -- inactive_winbar = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = { file_type, 'filename' },
  --   lualine_y = {},
  --   lualine_z = {}
  -- },
})
