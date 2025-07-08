local M = {}

local min_win_width = 85
local plugin_enabled = false
local win_expand_horizontal_direction = "right"
local win_hoarder_augroup = vim.api.nvim_create_augroup("WinHoarderLayout", { clear = true })

local function is_window_floating(win)
  local win_config = vim.api.nvim_win_get_config(win)
  return win_config.relative ~= ""
end

local function wished_min_width()
  -- TODO: Make it smarter, based on screen size and number of windows.
  return min_win_width
end

local function should_resize_windows_horizontally(layout)
  layout = layout or vim.fn.winlayout()

  if not plugin_enabled then
    return false
  end

  if is_window_floating(vim.api.nvim_get_current_win()) then
    return false
  end

  return true
end




-- Check if a layout subtree contains a given window
local function contains_win(layout, winid)
  if layout[1] == "leaf" then
    return layout[2] == winid
  else
    for _, child in ipairs(layout[2]) do
      if contains_win(child, winid) then
        return true
      end
    end
  end
  return false
end

-- Find the "row" node that contains the active window and a right neighbor
local function find_target_row(layout, active_winid)
  if layout[1] == "row" then
    local children = layout[2]
    for i = 1, #children - 1 do
      if contains_win(children[i], active_winid) then
        return layout, i, children[i], children[i + 1]
      end
    end
  end

  if layout[1] == "col" or layout[1] == "row" then
    for _, child in ipairs(layout[2]) do
      local row, idx, left, right = find_target_row(child, active_winid)
      if row then return row, idx, left, right end
    end
  end

  return nil
end

-- Collect all leaf window IDs in a layout subtree
local function collect_leaf_winids(layout, list)
  if layout[1] == "leaf" then
    table.insert(list, layout[2])
  else
    for _, child in ipairs(layout[2]) do
      collect_leaf_winids(child, list)
    end
  end
end

-- Main logic: compute and set widths
local function resize_windows(min_width)
  local layout = vim.fn.winlayout()
  local screen_width = vim.o.columns
  local active_win = vim.api.nvim_get_current_win()

  local row, idx, left_node, right_node = find_target_row(layout, active_win)

  if not row then
    vim.notify("No valid row found for active window", vim.log.levels.ERROR)
    return
  end

  -- Gather winids that need min_width
  local must_have_min = {}
  if left_node then collect_leaf_winids(left_node, must_have_min) end
  if right_node then collect_leaf_winids(right_node, must_have_min) end

  local must_have_min_set = {}
  for _, winid in ipairs(must_have_min) do
    must_have_min_set[winid] = true
  end

  local all_winids = {}
  collect_leaf_winids(row, all_winids)

  local result = {}
  local total_min = 0
  local others = {}

  for _, winid in ipairs(all_winids) do
    if must_have_min_set[winid] then
      table.insert(result, { winid = winid, width = min_width })
      total_min = total_min + min_width
    else
      table.insert(others, winid)
    end
  end

  local remaining = screen_width - total_min
  local shared = (#others > 0) and math.floor(remaining / #others) or 0

  for _, winid in ipairs(others) do
    table.insert(result, { winid = winid, width = shared })
  end

  -- Fix rounding
  local sum = 0
  for _, r in ipairs(result) do sum = sum + r.width end
  local diff = screen_width - sum
  if diff ~= 0 and #result > 0 then
    result[1].width = result[1].width + diff
  end

  -- Apply
  for _, r in ipairs(result) do
    pcall(vim.api.nvim_win_set_width, r.winid, r.width)
  end
end

vim.api.nvim_create_user_command("ResizeSmart", function()
  resize_windows(wished_min_width())
end, {})




local function resize_windows_horizontally()
  resize_windows(wished_min_width())
end

local function register_tracking_window_layout_update()
  vim.api.nvim_create_autocmd({ "WinEnter" }, {
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

  print("WinHoarderLayout - win_expand_horizontal_direction: " .. win_expand_horizontal_direction)

  if should_resize_windows_horizontally() then
    resize_windows_horizontally()
  end
end

function M.toggle_enabled()
  plugin_enabled = not plugin_enabled

  print("WinHoarderLayout is now " .. (plugin_enabled and "enabled" or "disabled"))

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
