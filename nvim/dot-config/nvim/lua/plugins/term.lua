local Job = require('plenary.job')
local Term = require('utils.term')

local M = {}

local FollowableTerms = {}

local function term_history_atuin()
  local commands = Job:new({
    'atuin',
    'search',
    '--cwd',
    vim.fn.getcwd(),
    '--format',
    '{command}',
    '--reverse'
  }):sync()

  return commands
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

local function jump_to_prompt(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local target = opts.forward
    and next_prompt_line({ bufnr = bufnr })
    or previous_prompt_line({ bufnr = bufnr })
  if target then
    vim.api.nvim_win_set_cursor(0, { target, 0 })
  end
end

local ok_repeatable_move, repeatable_move = pcall(require, 'nvim-treesitter-textobjects.repeatable_move')
if ok_repeatable_move then
  jump_to_prompt = repeatable_move.make_repeatable_move(jump_to_prompt)
end

function M.jump_previous_prompt()
  jump_to_prompt({ forward = false })
end

function M.jump_next_prompt()
  jump_to_prompt({ forward = true })
end

function M.create_or_focus(term_key, opts)
  opts = opts or {}
  local command = opts.command
  local height = opts.height or 15

  local term_buffer_id = FollowableTerms[term_key]
  if term_buffer_id ~= nil and vim.api.nvim_buf_is_valid(term_buffer_id) then
    local buffers_window_id = vim.fn.bufwinid(term_buffer_id)
    if buffers_window_id ~= -1 then
      vim.api.nvim_set_current_win(buffers_window_id)
    else
      vim.api.nvim_open_win(term_buffer_id, true, {
        split = 'below',
        height = height
      })
    end
  else
    if command == nil then
      term_buffer_id = Term.open_small_term()
    else
      term_buffer_id = Term.run_in_small_term(command)
    end
    vim.b.term_title = term_key
    FollowableTerms[term_key] = term_buffer_id
  end
end

function M.history()
  local history_commands = term_history_atuin() or {}

  vim.ui.select(history_commands, {
    prompt = 'Select command: ',
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice then
      Term.run_in_small_term(choice)
    end
  end
  )
end

return M
