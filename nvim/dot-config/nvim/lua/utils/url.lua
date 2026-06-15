local M = {}

M.open = function(url)
	vim.fn.system('open "' .. url .. '"')
end

return M
