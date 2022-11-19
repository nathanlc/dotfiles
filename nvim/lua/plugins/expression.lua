local ts_utils = require('nvim-treesitter.ts_utils')
local telescope = require('telescope.builtin')
local textcase = require('textcase')

local M = {}

local ts_current_symbol = function()
  local node = ts_utils.get_node_at_cursor(0)
  if not node then
    print('No node found under cursor.')
    return
  end
  local text_lines = ts_utils.get_node_text(node, 0)
  return table.concat(text_lines, '')
end

M.current_symbol = function()
  if not ts_utils then
    return vim.expand('<cexpr>')
  end
  return ts_current_symbol()
end

M.grep = function()
  local opts = {
    initial_mode = 'normal',
    default_text = M.current_symbol(),
  }
  telescope.live_grep(opts)
end

M.swoop = function()
  local opts = {
    initial_mode = 'normal',
    default_text = M.current_symbol(),
  }
  telescope.current_buffer_fuzzy_find(opts)
end

M.find_files = function()
  local symbol = M.current_symbol()

  local find_str = nil
  if vim.bo.filetype == 'ruby' then
    find_str = textcase.api.to_snake_case(symbol)
  else
    find_str = symbol
  end

  local opts = {
    initial_mode = 'normal',
    default_text = find_str,
  }
  telescope.find_files(opts)
end

M.help_tags = function()
  local opts = {
    initial_mode = 'normal',
    default_text = M.current_symbol(),
  }
  telescope.help_tags(opts)
end

M.lsp_workspace_symbols = function()
  local opts = {
    initial_mode = 'normal',
    default_text = M.current_symbol(),
  }
  telescope.lsp_workspace_symbols(opts)
end

return M
