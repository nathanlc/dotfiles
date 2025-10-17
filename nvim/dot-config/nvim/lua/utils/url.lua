local M = {}

M.open = function(url)
	vim.cmd('silent !open "' .. url .. '"')
end

return M
