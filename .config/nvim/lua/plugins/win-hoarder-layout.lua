local Array = require("utils.array")

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





local function contains_win(layout, winid)
  if layout[1] == "leaf" then
    return layout[2] == winid
  end

  for _, child in ipairs(layout[2]) do
    if contains_win(child, winid) then
      return true
    end
  end

  return false
end

local function find_target_row(layout, active_winid)
  if layout[1] == "row" then
    local children = layout[2]
    for i = 1, #children do
      if contains_win(children[i], active_winid) then
        return layout, i, children[i - 1], children[i], children[i + 1]
      end
    end
  end

  if layout[1] == "col" or layout[1] == "row" then
    for _, child in ipairs(layout[2]) do
      local row, idx, left, active, right = find_target_row(child, active_winid)
      if row then return row, idx, left, active, right end
    end
  end

  return nil
end

local function resize_windows_horizontally()
  local row, _, left, active, right = find_target_row(vim.fn.winlayout(), vim.api.nvim_get_current_win())

  if row == nil then
    vim.notify("WinHoarderLayout - No row found for the active window", vim.log.levels.DEBUG)
    return
  end

  assert(row[1] == "row", "Expected row layout")
  assert(row[2] ~= nil, "Expected row to have children")
  assert(active ~= nil, "Active window not found in layout")

  local wins_to_expand_ids = {}
  if (win_expand_horizontal_direction == "right" and right) then
    wins_to_expand_ids = { active[2], right[2] }
  elseif (win_expand_horizontal_direction == "left" and left) then
    wins_to_expand_ids = { left[2], active[2] }
  elseif (win_expand_horizontal_direction == "right" and not right and left) then
    wins_to_expand_ids = { left[2], active[2] }
  end

  local shrink_width = math.floor(vim.o.columns - wished_min_width() * #wins_to_expand_ids)
  local children = row[2]
  if shrink_width > wished_min_width() then
    local width = math.floor(vim.o.columns / #children)
    for _, child in ipairs(children) do
      if child[1] == "col" then
        vim.notify("WinHoarderLayout - Child is a column, TODO: implement", vim.log.levels.WARN)
        goto continue
      end

      vim.api.nvim_win_set_width(child[2], width)

      ::continue::
    end
  else
    for _, child in ipairs(children) do
      assert(child[1] == "leaf", "Child should be a leaf window")
      if child[1] == "col" then
        vim.notify("WinHoarderLayout - Child is a column, TODO: implement", vim.log.levels.WARN)
        goto continue
      end
      -- TODO: Handle case where child is a column (there is no row inside a row, it would have been the same row)
      -- If it's a column, only resize the first child. The children won't be a row, otherwise that nested row would have been returned by find_target_row.
      if Array.contains(wins_to_expand_ids, child[2]) then
        vim.api.nvim_win_set_width(child[2], wished_min_width())
      else
        vim.api.nvim_win_set_width(child[2], shrink_width)
      end

      ::continue::
    end
  end
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

  vim.notify("WinHoarderLayout - win_expand_horizontal_direction: " .. win_expand_horizontal_direction,
    vim.log.levels.INFO)

  if should_resize_windows_horizontally() then
    resize_windows_horizontally()
  end
end

function M.toggle_enabled()
  plugin_enabled = not plugin_enabled

  vim.notify("WinHoarderLayout is now " .. (plugin_enabled and "enabled" or "disabled"), vim.log.levels.INFO)

  if plugin_enabled and should_resize_windows_horizontally() then
    resize_windows_horizontally()
  end
end

function M.setup(opts)
  opts = opts or {}
  if opts.enabled == nil then
    plugin_enabled = true
  else
    plugin_enabled = opts.enabled
  end
  win_expand_horizontal_direction = opts.expand_horizontal_direction or "right"
  min_win_width = opts.min_win_width or 85

  register_autocmds()
end

return M
