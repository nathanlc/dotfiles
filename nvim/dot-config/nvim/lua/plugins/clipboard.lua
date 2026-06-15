local Path = require('plenary.path')


local M = {}

local clips_file = vim.fn.stdpath('cache') .. '/clipboards.txt'

local function get_clips_file_path()
  local clips_file_path = Path:new(clips_file)
  if not clips_file_path:is_file() then
    return nil
  end
  return clips_file_path
end

local function get_clips()
  local clips_file_path = get_clips_file_path()
  if not clips_file_path then error('Could not get clips file path') end

  local clip_lines = clips_file_path:readlines()
  local clips = {}
  local next_line_type = 'desc'
  local next_clip = {
    desc = nil,
    value = nil
  }
  for _, line in ipairs(clip_lines) do
    if next_line_type == 'desc' then
      next_clip.desc = line
      next_line_type = 'value'
    elseif next_line_type == 'value' then
      next_clip.value = line
      next_line_type = 'delimiter'
      table.insert(clips, next_clip)
      next_clip = {
        desc = nil,
        value = nil
      }
    elseif next_line_type == 'delimiter' then
      if line ~= '' then error('Incorrect delimiter found, should be a blank line.') end
      next_line_type = 'desc'
    end
  end

  return clips
end

function M.edit()
  local clips_file_path = get_clips_file_path()
  if not clips_file_path then
    print('Could not get clips file path')
    return
  end

  vim.cmd('edit ' .. clips_file_path.filename)
end

function M.select_and_copy()
  local clips = get_clips()
  local descriptions = {}
  for _, clip in ipairs(clips) do
    table.insert(descriptions, clip.desc)
  end

  vim.ui.select(descriptions, {
    prompt = 'Select clipboard entry: ',
    format_item = function(item)
      return item
    end,
  }, function(choice, idx)
    if choice then
      local clip = clips[idx].value
      vim.fn.setreg('+', clip)
    end
  end
  )
end

return M
