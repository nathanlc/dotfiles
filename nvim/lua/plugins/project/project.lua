local scandir = require('plenary.scandir').scan_dir
local Path = require('plenary.path')
-- local buffer = require('utils.buffer')
local term = require('utils.term')
local Table = require('utils.table')
local Buffer = require('utils.buffer')

-- local win
-- local buffer_max_line = 3
local home = os.getenv('HOME')
local root = home .. '/sandbox'
local recent_projects_file = vim.fn.stdpath('cache') .. '/recent_projects.txt'
ConfiguredProjects = {}

local function get_project_name(project_dir)
  return vim.fn.fnamemodify(project_dir, ':t')
end

local function find_project_dirs()
  local git_dirs = scandir(root, {
    hidden = true,
    -- only_dirs = true,
    add_dirs = true,
    depth = 3,
    search_pattern = '%.git$'
  })

  local project_dirs = {}
  for i, v in ipairs(git_dirs) do
    local git_path = Path:new(v)
    local project_path = git_path:parent()
    project_dirs[i] = '~/' .. project_path:normalize(home)
  end

  return project_dirs
end

-- local function move_cursor_up()
--   local new_pos = math.max(buffer_max_line, vim.api.nvim_win_get_cursor(win)[1] - 1)
--   vim.api.nvim_win_set_cursor(win, { new_pos, 0 })
-- end

-- local function close_window()
--   vim.api.nvim_win_close(win, true)
-- end

local function get_recents_file()
  local recent_projects_path = Path:new(recent_projects_file)
  if not recent_projects_path:is_file() then
    return nil
  end
  return recent_projects_path
end

local function update_recent_projects(project_path)
  local recent_projects_path = get_recents_file()
  if recent_projects_path == nil then
    print('Could not update recent projects.')
    return
  end

  local recent_projects = recent_projects_path:readlines()
  local recent_projects_filtered = Table.filter(function(v)
    return v ~= "" and v ~= project_path
  end, recent_projects)

  table.insert(recent_projects_filtered, project_path)

  recent_projects_path:write(
    table.concat(recent_projects_filtered, "\n"),
    'w',
    438
  )
end

local function get_recents()
  local recent_projects_path = get_recents_file()
  if recent_projects_path == nil then
    print('Could not get recent projects.')
    return nil
  end

  local recent_projects = recent_projects_path:readlines()
  local clean_list = Table.filter(function(v)
    return v ~= ''
  end, recent_projects)

  return Table.reverse(clean_list)
end

local function configure_project(project_path)
  local conf_path = project_path .. '/.project-nvim.json'
  local project_name = get_project_name(project_path)
  local conf_file = Path:new(conf_path)
  if not conf_file:is_file() then
    print(conf_path .. ' not found.')
    return
  end
  local conf_string = conf_file:read()
  local conf = vim.fn.json_decode(conf_string)

  ConfiguredProjects[project_name] = {
    console = conf['console'],
    test = conf['test'],
    repl = conf['repl'],
  }
end

local function open_project(project_path)
  -- Removed because using telescope instead
  -- close_window()
  vim.api.nvim_command('lcd ' .. project_path)
  update_recent_projects(project_path)
  configure_project(project_path)
  vim.api.nvim_command('edit .')
  if require('lualine') then
    vim.api.nvim_command('LualineRenameTab ' .. get_project_name(project_path))
  end
end

-- local function open_project_current()
--   open_project(vim.api.nvim_get_current_line())
-- end

local function open_project_tab(project_path)
  vim.api.nvim_command('tabnew')
  open_project(project_path)
end

-- local function set_mappings(buff)
--   local mappings = {
--     ['<Esc>'] = 'close_window()',
--     q = 'close_window()',
--     ['<CR>'] = 'open_project_current()',
--     t = 'open_project_tab()',
--     k = 'move_cursor_up()',
--   }

--   for k, v in pairs(mappings) do
--     vim.api.nvim_buf_set_keymap(buff, 'n', k, ':lua require("plugins.project.project").' .. v .. '<CR>', {
--       nowait = true,
--       noremap = true,
--       silent = true,
--     })
--   end
-- end

-- Deprecated, using telescope
-- local function open_window()
--   local buf = vim.api.nvim_create_buf(false, true)
--   buffer.set_options(buf, {
--     bufhidden = 'wipe',
--     filetype = 'project_picker',
--   })

--   local screen_width = vim.api.nvim_get_option('columns')
--   local screen_height = vim.api.nvim_get_option('lines')
--   local win_width = math.ceil(screen_width * 0.8)
--   local win_height = math.ceil(screen_height * 0.8 - 4)
--   local row = math.ceil((screen_height - win_height) / 2 - 1)
--   local col = math.ceil((screen_width - win_width) / 2)
--   local win_opts = {
--     style = "minimal",
--     relative = "editor",
--     width = win_width,
--     height = win_height,
--     row = row,
--     col = col
--   }

--   win = vim.api.nvim_open_win(buf, true, win_opts)

--   local lines = { 'Project Picker', '' }
--   for _, v in ipairs(find_project_dirs()) do
--     table.insert(lines, v)
--   end

--   vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
--   vim.api.nvim_buf_set_option(buf, 'modifiable', false)
--   vim.api.nvim_win_set_cursor(win, { buffer_max_line, 0 })
--   set_mappings(buf)
-- end

local function open_telescope(opts)
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Project picker",
    finder = finders.new_table {
      results = find_project_dirs()
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        open_project(selection[1])
      end)
      actions.select_tab:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        open_project_tab(selection[1])
      end)

      return true
    end,
  }):find()
end

local function get_current_project_name()
  local current_dir = vim.fn.getcwd()
  return get_project_name(current_dir)
end

local function get_current_config()
  local project_name = get_current_project_name()
  return ConfiguredProjects[project_name]
end

local function reload_config()
  configure_project(vim.fn.getcwd())
  print(get_current_project_name() .. ' config reloaded.')
end

local function run_console()
  local project_config = get_current_config()
  local config_key = 'console'

  if project_config and project_config[config_key] then
    term.run_in_term(project_config[config_key])
    vim.api.nvim_command('startinsert')
  else
    print(config_key .. ': command not configured')
  end
end

local function run_repl()
  local project_config = get_current_config()
  local config_key = 'repl'

  if project_config and project_config[config_key] then
    term.run_in_term(project_config[config_key])
    vim.api.nvim_command('startinsert')
  else
    print(config_key .. ': command not configured')
  end
end

local function run_test_suite()
  local window = vim.api.nvim_get_current_win()

  local project_config = get_current_config()
  local test_key = 'test'
  local command_key = 'command'
  local dir_key = 'dir'

  if project_config
    and project_config[test_key]
    and project_config[test_key][command_key]
    and project_config[test_key][dir_key] then
    local test_cmd = project_config[test_key][command_key]
      .. ' '
      .. project_config[test_key][dir_key]
    term.run_in_term(test_cmd)
  elseif vim.g.loaded_dispatch then
    vim.api.nvim_command('Dispatch')
  else
    print('Project not configured correctly for testing.')
    vim.pretty_print(project_config)
  end

  vim.api.nvim_set_current_win(window)
end

local function run_test_file(buffer)
  local window = vim.api.nvim_get_current_win()

  local project_config = get_current_config()
  local test_key = 'test'
  local command_key = 'command'
  local buffer_path = Path:new(vim.api.nvim_buf_get_name(buffer))
  local file_path = buffer_path:normalize(vim.fn.getcwd())

  if project_config
    and project_config[test_key]
    and project_config[test_key][command_key] then
    local test_cmd = project_config[test_key][command_key]
      .. ' '
      .. file_path
    term.run_in_term(test_cmd)
  elseif vim.g.loaded_dispatch then
    vim.api.nvim_command('Dispatch')
  else
    print('Project not configured correctly for testing.')
    vim.pretty_print(project_config)
  end

  vim.api.nvim_set_current_win(window)
end

local function run_test_current(buffer, line)
  local window = vim.api.nvim_get_current_win()

  local project_config = get_current_config()
  local test_key = 'test'
  local command_key = 'command'
  local buffer_path = Path:new(vim.api.nvim_buf_get_name(buffer))
  local file_path = buffer_path:normalize(vim.fn.getcwd())
    .. ':' .. line

  if project_config
    and project_config[test_key]
    and project_config[test_key][command_key] then
    local test_cmd = project_config[test_key][command_key]
      .. ' '
      .. file_path
    term.run_in_term(test_cmd)
  elseif vim.g.loaded_dispatch then
    vim.api.nvim_command('Dispatch')
  else
    print('Project not configured correctly for testing.')
    vim.pretty_print(project_config)
  end

  vim.api.nvim_set_current_win(window)
end

local function run_verify()
  local project_config = get_current_config()
  local config_key = 'verify'

  if project_config and project_config[config_key] then
    term.run_in_term(project_config[config_key])
  else
    print(config_key .. ': command not configured')
  end
end

local function project_terms_count()
  local buffers = Buffer.list()
  local project_name = get_current_project_name()
  local escaped_project_name = string.gsub(project_name, '-', '.')
  local pattern = 'term://.*' .. escaped_project_name
  local count = 0
  for _, bName in pairs(buffers) do
    if string.match(bName, pattern) ~= nil then
      count = count + 1
    end
  end

  return count
end

local function project_terms_picker()
  local project_name = get_current_project_name()
  local default_text = 'term://' .. project_name
  require('telescope.builtin').buffers({default_text = default_text, initial_mode = "normal"})
end

return {
  open_telescope = open_telescope,
  open_project = open_project,
  run_console = run_console,
  run_repl = run_repl,
  run_test_suite = run_test_suite,
  run_test_file = run_test_file,
  run_test_current = run_test_current,
  run_verify = run_verify,
  reload_config = reload_config,
  get_recents = get_recents,
  project_terms_count = project_terms_count,
  project_terms_picker = project_terms_picker,
}
