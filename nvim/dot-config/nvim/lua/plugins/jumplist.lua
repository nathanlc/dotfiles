local M = {}

local function jump_up_n_times(n_times)
	for _ = 1, n_times do
		vim.cmd('exe "normal! \\<C-o>"')
	end
end

local function jump_down_n_times(n_times)
	for _ = 1, n_times do
		vim.cmd('exe "normal! \\<C-i>"')
	end
end

function M.jump_to_previous_file()
	local result = vim.fn.getjumplist()
	local jumplist = result[1]
	local current_index = result[2]
	local bufnr = vim.api.nvim_get_current_buf()

	for i = (current_index), 1, -1 do
		if jumplist[i].bufnr ~= bufnr then
			local number_jumps = current_index + 1 - i
			jump_up_n_times(number_jumps)
			return
		end
	end
end

function M.jump_to_next_file()
	local result = vim.fn.getjumplist()
	local jumplist = result[1]
	local current_index = result[2]
	local bufnr = vim.api.nvim_get_current_buf()

	for i = current_index, #jumplist, 1 do
		if jumplist[i].bufnr ~= bufnr then
			local number_jumps = i - current_index
			jump_down_n_times(number_jumps)
			return
		end
	end
end

return M
