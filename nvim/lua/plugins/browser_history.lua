local Job = require('plenary.job')
local Path = require('plenary.path')

local Table = require('utils.table')


local M = {}

local function get_browser_history_lines(database)
  local database_path = Path:new(database)
  if not database_path:is_file() then
    print('Could not get browser history database path')
    return nil
  end

  return Job:new({
    command = 'sqlite3',
    args = {
      database,
      'select title, url from urls order by last_visit_time;',
    },
  }):sync()
end

local function get_browser_history(database)
  local history_lines = get_browser_history_lines(database)
  if not history_lines then
    print('Got empty history.')
    return {}
  end

  local histories = Table.map(function(line)
    local title, url = line:match('(.+)|(.+)')
    return {
      desc = title,
      value = url,
    }
  end, history_lines)

  return Table.filter(function(history)
    return next(history) ~= nil
  end, histories)
end

function M.telescope(opts)
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local previewers = require('telescope.previewers')
  local conf = require('telescope.config').values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  local database = opts.database

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Clipboards",
    finder = finders.new_table({
      results = get_browser_history(database),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.desc .. ' | ' .. entry.value,
          ordinal = entry.desc,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry)
        return { 'echo', entry.value.desc .. '\n' .. entry.value.value }
      end,
    }),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        Job:new({
          command = 'open',
          args = { selection.value.value },
          on_exit = function(job)
            vim.pretty_print(job)
          end
        }):sync()
      end)

      return true
    end,
  }):find()
end

return M
