local M = {}

function M.find(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end

function M.contains(array, value)
	return M.find(array, value) ~= nil
end

return M
