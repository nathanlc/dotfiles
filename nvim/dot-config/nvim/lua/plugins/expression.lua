local textcase = require('textcase')
local docs_plugin = require('plugins.docs')

local M = {}

local expression_cycles = {
  {"true", "false"},
  {"True", "False"},
  {"public", "private", "protected"},
  {"debug", "info", "warn", "error"},
}

M.cycle = function()
  local current = vim.fn.expand('<cword>')
  for _, cycle in ipairs(expression_cycles) do
    for i, value in ipairs(cycle) do
      if value == current then
        local next_value = cycle[(i % #cycle) + 1]
        vim.cmd('normal ciw' .. next_value)
        return
      end
    end
  end
end

local ts_current_symbol = function()
  local ok, node = pcall(vim.treesitter.get_node)
  if not ok or not node then
    return nil
  end
  return vim.treesitter.get_node_text(node, 0)
end

M.current_symbol = function()
  local symbol = ts_current_symbol()
  if not symbol or symbol == '' then
    return vim.fn.expand('<cexpr>')
  end
  return symbol
end

M.current_symbol_to_file = function()
  local symbol = M.current_symbol()

  if vim.bo.filetype == 'ruby' then
    return textcase.api.to_snake_case(symbol)
  else
    return symbol
  end
end

M.docs = function ()
  local symbol = M.current_symbol()
  docs_plugin.search(symbol)
end

return M
