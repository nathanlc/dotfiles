local M = {}

M.trim = function(str)
  return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

return M
