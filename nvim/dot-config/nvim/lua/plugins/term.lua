local Job = require('plenary.job')
local Term = require('utils.term')

local M = {}

local function term_history_atuin()
  local commands = Job:new({
    'atuin',
    'search',
    '--format',
    '{command}',
    '--reverse'
  }):sync()

  return commands
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
      results = term_history_atuin(),
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        Term.run_in_term_current(selection[1])
      end)
      actions.select_horizontal:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        Term.run_in_term(selection[1])
      end)

      return true
    end,
  }):find()
end

local function find_prompt_lines(opts)
  opts = opts or {}
  local start = opts.start or 0
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local prompt_lines = opts.prompt_lines or {}

  if not vim.api.nvim_buf_is_valid(bufnr) then
    vim.print("Invalid buffer: ", bufnr)
    return prompt_lines
  end

  local buf_lines = vim.api.nvim_buf_get_lines(bufnr, start, -1, false)

  for i, line in ipairs(buf_lines) do
    if line:match('^❯') then
      table.insert(prompt_lines, i + start)
    end
  end

  return prompt_lines
end

local function previous_prompt_line(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local win = opts.win or vim.api.nvim_get_current_win()
  local cursor_line, _ = unpack(vim.api.nvim_win_get_cursor(win))
  local prompt_lines = opts.prompt_lines or find_prompt_lines({ bufnr = bufnr })

  if #prompt_lines == 0 then
    return nil
  end

  if cursor_line < prompt_lines[1] then
    return nil
  end

  for i, prompt_line in ipairs(prompt_lines) do
    if prompt_lines[i - 1] and prompt_lines[i - 1] < cursor_line and cursor_line <= prompt_line then
      return prompt_lines[i - 1]
    end
  end

  return prompt_lines[#prompt_lines]
end

local function next_prompt_line(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local win = opts.win or vim.api.nvim_get_current_win()
  local cursor_line, _ = unpack(vim.api.nvim_win_get_cursor(win))
  local prompt_lines = opts.prompt_lines or find_prompt_lines({ bufnr = bufnr })

  if #prompt_lines == 0 then
    return nil
  end

  if cursor_line > prompt_lines[#prompt_lines] then
    return nil
  end

  for _, prompt_line in ipairs(prompt_lines) do
    if prompt_line > cursor_line then
      return prompt_line
    end
  end

  return nil
end

function M.jump_previous_prompt(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

  vim.api.nvim_win_set_cursor(0, { previous_prompt_line({bufnr = bufnr}), 0 })
end

function M.jump_next_prompt(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

  vim.api.nvim_win_set_cursor(0, { next_prompt_line({bufnr = bufnr}), 0 })
end

local ok_repeatable_move, repeatable_move = pcall(require, 'nvim-treesitter.textobjects.repeatable_move' )
if ok_repeatable_move then
  M.jump_previous_prompt, M.jump_next_prompt = repeatable_move.make_repeatable_move_pair(M.jump_previous_prompt, M.jump_next_prompt)
end

return M
