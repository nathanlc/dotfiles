local Path = require('plenary.path')
local Buffer = require('utils.buffer')
local String = require('utils.string')
local Table = require('utils.table')
local Project = require('plugins.project.project')
local github = require('plugins.github')

local M = {}
local home_dir = os.getenv('HOME')

local function normalize(path, from)
  if not string.find(path, from) then
    return path
  end

  local n_path = Path:new(path)
  return '~/' .. n_path:normalize(from)
end

local function old_files()
  -- local ignore_files = {
  --   '[packer]',
  --   'NetrwTreeListing',
  -- }
  local files = vim.v.oldfiles
  -- local filtered_files = Table.filter(function(f)
  --   for _, v in ipairs(ignore_files) do
  --     if string.match(f, v) ~= nil then
  --       return false
  --     end
  --   end
  --   return true
  -- end, files)
  local normalized_files = Table.map(function(f)
    return normalize(f, home_dir)
  end, files)
  return Table.head(8, normalized_files)
end

local function format_pr(pr)
  return pr.title .. ': ' .. pr.url
end

local function prs_to_review()
  local prs_formatted = {}
  github.prs_to_review(false, function(prs_json)
    prs_formatted = Table.map(format_pr, prs_json)
  end)
  return prs_formatted
end

local function prs_ongoing()
  local prs_formatted = {}
  github.prs_ongoing(false, function(prs_json)
    prs_formatted = Table.map(format_pr, prs_json)
  end)
  return prs_formatted
end

function M.startup()
  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('nathanlc:Home', { clear = true }),
    pattern = '*',
    callback = function()
      M.home()
    end
  })
end

local function on_select(line)
  local path_string = String.trim(line)
  local expanded_path_string = vim.fn.expand(path_string)
  local path = Path:new(expanded_path_string)

  if path:is_file() then
    vim.api.nvim_command('edit ' .. path_string)
    return
  end

  if path:is_dir() then
    Project.open_project(path_string)
    return
  end
end

function M.on_select_tab()
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_command('tabnew')
  on_select(line)
end

function M.on_select_current()
  local line = vim.api.nvim_get_current_line()
  on_select(line)
end

function M.home()
  local bufnr = vim.api.nvim_create_buf(false, true)
  Buffer.set_options(bufnr, {
    bufhidden = 'wipe',
    filetype = 'nathanlc_home',
  })

  local recent_projects = Table.head(5, Project.get_recents())
  local lines = Table.concat({
    {
      '',
      'Home',
    },
    {
      '',
      'Recent projects (p)'
    },
    recent_projects,
    {
      '',
      'Recent files (o)',
    },
    old_files(),
    {
      '',
      'PRs to review',
    },
    prs_to_review(),
    {
      '',
      'PRs ongoing',
    },
    prs_ongoing(),
  })
  local padded_lines = Table.map(function(l)
    if l == '' then
      return l
    end
    return '    ' .. l
  end, lines)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, padded_lines)

  vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
  vim.api.nvim_buf_set_mark(bufnr, 'p', 5, 1, {})
  vim.api.nvim_buf_set_mark(bufnr, 'o', 5 + #recent_projects + 2, 1, {})

  vim.api.nvim_set_current_buf(bufnr)
  vim.api.nvim_command("normal 'p")

  local map_opts = { nowait = true, noremap = true, silent = true, }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', [[<Cmd>lua require('plugins.home').on_select_current()<CR>]], map_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-t>', [[<Cmd>lua require('plugins.home').on_select_tab()<CR>]], map_opts)
end

return M
