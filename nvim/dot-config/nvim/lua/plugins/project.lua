local Path = require('plenary.path')
local Job = require('plenary.job')
local Term = require('plugins.term')

local pname = '.project-nvim.json'
ConfiguredProjects = {}

local function get_project_name(project_dir)
  return vim.fn.fnamemodify(project_dir, ':t')
end

local function load_project_conf(project_path)
  local conf_path = project_path .. '/' .. pname
  local project_name = get_project_name(project_path)
  local conf_file = Path:new(conf_path)
  if not conf_file:is_file() then
    error(conf_path .. ' not found.')
  end

  local conf_string = conf_file:read()
  local conf = vim.fn.json_decode(conf_string)

  ConfiguredProjects[project_name] = conf
end

local function open_jira()
  return Job:new({
    'git',
    'branch',
    '--show-current',
    on_exit = function(job)
      local output = job:result()[1]
      if output == nil or output == '' then
        print('project#open_jira: No branch found.')
        return
      end
      local ticket = string.match(output, '^%u+%-%d+')
      local url = 'https://glooko.atlassian.net/browse/' .. ticket
      vim.schedule(function()
        vim.cmd('silent !open "' .. url .. '"')
      end)
    end
  }):start()
end


local function get_current_project_name()
  local current_dir = vim.fn.getcwd()
  return get_project_name(current_dir)
end

local function edit_project_config()
  vim.cmd('edit ' .. pname)
end

local get_project_config = function(project_name)
  return ConfiguredProjects[project_name]
end

local get_project_config_value = function(project_name, config_key)
  local project_config = get_project_config(project_name) or {}
  return project_config[config_key]
end

local set_project_config_value = function(project_name, config_key, config_value)
  local project_config = get_project_config(project_name) or {}
  project_config[config_key] = config_value
  ConfiguredProjects[project_name] = project_config
end

local function reload_config()
  load_project_conf(vim.fn.getcwd())
  print(get_current_project_name() .. ' config reloaded.')
end

local function repl()
  local project_name = get_current_project_name()
  local repl_command = get_project_config_value(project_name, 'repl')
  if repl_command == nil then error('No repl command found for project ' .. project_name) end

  Term.create_or_focus('REPL', {command = repl_command})
  -- local repl_buffer_id = get_project_config_value(project_name, 'repl_buffer_id')
  -- if repl_buffer_id ~= nil and vim.api.nvim_buf_is_valid(repl_buffer_id) then
  --   local buffers_window_id = vim.fn.bufwinid(repl_buffer_id)
  --   if buffers_window_id ~= -1 then
  --     vim.api.nvim_set_current_win(buffers_window_id)
  --   else
  --     vim.api.nvim_open_win(repl_buffer_id, true, {
  --       split = 'below',
  --       height = 15
  --     })
  --   end
  -- else
  --   repl_buffer_id = Term.run_in_small_term(repl_command)
  --   set_project_config_value(project_name, 'repl_buffer_id', repl_buffer_id)
  -- end
end

return {
  open_jira = open_jira,
  repl = repl,
  reload_config = reload_config,
  edit_project_config = edit_project_config,
}
