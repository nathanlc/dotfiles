local utils_url = require('utils.url')

local M = {}

M.search = function(query)
  local filetype = vim.bo.filetype
  local url = nil
  if filetype == 'ruby' then
    url = 'https://rubyapi.org/o/s?q='
  else
    print('Not supported for filetype: ' .. filetype)
    return
  end

  if query == nil or query == '' then
    query = vim.fn.input(url)
  end

  utils_url.open(url .. query)
end

return M
