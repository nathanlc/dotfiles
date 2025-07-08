-- TODO:
-- - Currently there is a problem when there are 2 windows split vertically and one split horizontally.
--   That counts as 3 windows but only the vertical splits are relevant for resizing.
--   => Use vim.fn.layout()
--   => WIP ./win-hoarder-layout.lua
local M = {}

local min_win_width = 85
local plugin_enabled = false
local win_expand_horizontal_direction = "right"
local win_hoarder_augroup = vim.api.nvim_create_augroup("WinHoarder", { clear = true })

local function round(x)
	return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

local function table_find(t, value)
	for i, v in ipairs(t) do
		if v == value then
			return i
		end
	end
	return nil
end

local function is_window_floating(win)
	local win_config = vim.api.nvim_win_get_config(win)
	return win_config.relative ~= ""
end

local function reject_floating_windows(windows)
	local filtered_windows = {}
	for _, win in ipairs(windows) do
		if not is_window_floating(win) then
			table.insert(filtered_windows, win)
		end
	end
	return filtered_windows
end

local function wished_min_width()
	local windows = vim.api.nvim_tabpage_list_wins(0)
	local non_floating_windows = reject_floating_windows(windows)

	return math.max(
		math.floor(vim.o.columns / #non_floating_windows),
		min_win_width
	)
	-- if vim.o.columns > 240 then
	-- 	return 120
	-- else
	-- 	return 80
	-- end
end

local function should_resize_windows_horizontally()
	if not plugin_enabled then
		return false
	end

	if is_window_floating(vim.api.nvim_get_current_win()) then
		return false
	end

	local windows = vim.api.nvim_tabpage_list_wins(0)

	return #windows > 1 and vim.o.columns < wished_min_width() * #windows
end

local function sort_windows_by_column_position(windows)
	table.sort(windows, function(a, b)
		local _, a_col = unpack(vim.api.nvim_win_get_position(a))
		local _, b_col = unpack(vim.api.nvim_win_get_position(b))
		return a_col < b_col
	end)
end

local function resize_windows_horizontally()
	assert(vim.api.nvim_get_current_win(), "Expected current window to be valid")
	local current_win = vim.api.nvim_get_current_win()

	local windows = vim.api.nvim_tabpage_list_wins(0)
	windows = reject_floating_windows(windows)
	sort_windows_by_column_position(windows)
	-- There are 2 windows that we want to have the minimum width:
	-- - Window where cursor is.
	-- - Window to the right of it too.
	-- - If there is no window to the right (i.e. current window is the last one), then we want the last 2 windows.
	local position_of_current_win = table_find(windows, current_win)
	local windows_to_have_expanded = { windows[position_of_current_win] }
	-- TODO: Handle case where the screen width is too small to fit 2 windows in "full" width.
	if win_expand_horizontal_direction == "right" then
		if position_of_current_win == #windows then
			table.insert(windows_to_have_expanded, windows[#windows - 1])
		else
			table.insert(windows_to_have_expanded, windows[position_of_current_win + 1])
		end
	else
		if position_of_current_win == 1 then
			table.insert(windows_to_have_expanded, windows[2])
		else
			table.insert(windows_to_have_expanded, windows[position_of_current_win - 1])
		end
	end
	local number_windows_to_shrink = #windows - #windows_to_have_expanded
	local space_left_after_expanded = vim.o.columns - wished_min_width() * #windows_to_have_expanded
	local window_shrink_width = round(space_left_after_expanded / number_windows_to_shrink)
	for _, win in ipairs(windows) do
		if vim.tbl_contains(windows_to_have_expanded, win) then
			vim.api.nvim_win_set_width(win, wished_min_width())
		else
			vim.api.nvim_win_set_width(win, window_shrink_width)
		end
	end
end

local function register_tracking_window_layout_update()
	vim.api.nvim_create_autocmd({ "WinNew", "WinEnter" }, {
		group = win_hoarder_augroup,
		callback = function()
			if should_resize_windows_horizontally() then
				resize_windows_horizontally()
			end
		end,
	})
end

local function register_autocmds()
	register_tracking_window_layout_update()
end

function M.toggle_expand_horizontal_direction()
	if win_expand_horizontal_direction == "right" then
		win_expand_horizontal_direction = "left"
	else
		win_expand_horizontal_direction = "right"
	end

	print("WinHoarder - win_expand_horizontal_direction: " .. win_expand_horizontal_direction)

	if should_resize_windows_horizontally() then
		resize_windows_horizontally()
	end
end

function M.toggle_enabled()
	plugin_enabled = not plugin_enabled

	print("WinHoarder is now " .. (plugin_enabled and "enabled" or "disabled"))

	if plugin_enabled and should_resize_windows_horizontally() then
		resize_windows_horizontally()
	end
end

function M.setup(opts)
	opts = opts or {}
	win_expand_horizontal_direction = opts.expand_horizontal_direction or "right"
	plugin_enabled = opts.enabled or true
	min_win_width = opts.min_win_width or 85

	register_autocmds()
end

return M
