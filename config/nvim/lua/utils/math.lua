local M = {}

function M.round(x)
	return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

return M
