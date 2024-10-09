local M = {}

--- @param a integer
--- @param b integer
--- @return integer
function M.max(a, b)
	if a >= b then
		return a
	else
		return b
	end
end

return M
