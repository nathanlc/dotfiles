local M = {}

function M.add()
	local title = vim.fn.input("Title: ")
	local res = vim.fn.system("gcal add -c c_f668c803574491b3d02183466659339d556aaa5ac2a09a0176ed048c91eddba2@group.calendar.google.com -t \"" .. title .. "\"")
	print(res)
end

return M
