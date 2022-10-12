local Project = require('plugins.project.project')
local Path = require('plenary.path')
local Table = require('utils.table')

local M = {}
local home_dir = os.getenv('HOME')

function M.recent_projects()
  local projects = Table.head(5, Project.get_recents())

  return {
    title = 'Recent projects',
    mark = 'p',
    lines = projects,
    on_select = function(line)
      Project.open_project(line)
    end
  }
end

local function normalize(path, from)
  if not string.find(path, from) then
    return path
  end

  local n_path = Path:new(path)
  return '~/' .. n_path:normalize(from)
end

function M.old_files()
  local old_files = vim.v.oldfiles
  local normalized_files = Table.map(function(f)
    return normalize(f, home_dir)
  end, old_files)
  local files = Table.head(8, normalized_files)

  return {
    title = 'Recent files',
    mark = 'o',
    lines = files,
    on_select = function(line)
      vim.api.nvim_command('edit ' .. line)
    end
  }
end

return M
