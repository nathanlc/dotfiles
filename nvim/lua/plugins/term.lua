local Path = require('plenary.path')

local Table = require('utils.table')
local Term = require('utils.term')


local M = {}
local home = os.getenv('HOME')

local function term_history()
  local history_filename = home .. '/.bash_history'
  local history_path = Path:new(history_filename)
  if not history_path:is_file() then
    return { 'echo "No history file found."' }
  end
  local history_lines = history_path:readlines()
  local commands = Table.filter(function(line)
    return not line:match('^#')
  end, history_lines)

  return Table.unique(commands)
end

function M.history(opts)
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Term history",
    finder = finders.new_table({
      results = term_history(),
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        Term.run_in_term(selection[1])
      end)

      return true
    end,
  }):find()
end

return M
