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
  if not clips_file_path then
    print('Could not get clips file path')
    return nil
  end

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
      if line ~= '' then
        print('Incorrect delimiter found, should be a blank line.')
        return nil
      end
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

function M.telescope(opts)
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Clipboards",
    finder = finders.new_table({
      results = get_clips(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.desc .. ': ' .. entry.value,
          ordinal = entry.desc,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local clip = selection.value.value
        vim.fn.setreg('+', clip)
      end)

      return true
    end,
  }):find()
end

return M
