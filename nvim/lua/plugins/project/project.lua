local scandir = require('plenary.scandir').scan_dir
local Path = require('plenary.path')
local buffer = require('utils.buffer')
-- local buffer = require('../../utils.buffer')

local win
local buffer_max_line = 3
local home = os.getenv('HOME')
local root = home .. '/sandbox'

local function find_project_dirs()
  local git_dirs = scandir(root, {
    hidden = true,
    only_dirs = true,
    depth = 3,
    search_pattern = '.git'
  })

  local project_dirs = {}
  for i, v in ipairs(git_dirs) do
    local git_path = Path:new(v)
    local project_path = git_path:parent()
    project_dirs[i] = '~/' .. project_path:normalize(home)
  end

  return project_dirs
end

local function move_cursor_up()
  local new_pos = math.max(buffer_max_line, vim.api.nvim_win_get_cursor(win)[1] - 1)
  vim.api.nvim_win_set_cursor(win, {new_pos, 0})
end

local function close_window()
  vim.api.nvim_win_close(win, true)
end

local function open_project(project_path)
  close_window()
  vim.api.nvim_command('lcd ' .. project_path)
  vim.api.nvim_command('edit .')
end

local function open_project_current()
  open_project(vim.api.nvim_get_current_line())
end

local function open_project_tab()
  local project_path = vim.api.nvim_get_current_line()
  vim.api.nvim_command('tabnew')
  open_project(project_path)
end

local function set_mappings(buff)
  local mappings = {
    ['<Esc>'] = 'close_window()',
    q = 'close_window()',
    ['<CR>'] = 'open_project_current()',
    t = 'open_project_tab()',
    k = 'move_cursor_up()',
  }

  for k, v in pairs(mappings) do
    vim.api.nvim_buf_set_keymap(buff, 'n', k, ':lua require("plugins.project.project").' .. v .. '<CR>', {
      nowait = true,
      noremap = true,
      silent = true,
    })
  end
end

local function open_window()
  local buf = vim.api.nvim_create_buf(false, true)
  buffer.set_options(buf, {
    bufhidden = 'wipe',
    filetype = 'project_picker',
  })

  local screen_width = vim.api.nvim_get_option('columns')
  local screen_height = vim.api.nvim_get_option('lines')
  local win_width = math.ceil(screen_width * 0.8)
  local win_height = math.ceil(screen_height * 0.8 - 4)
  local row = math.ceil((screen_height - win_height) / 2 - 1)
  local col = math.ceil((screen_width - win_width) / 2)
  local win_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  win = vim.api.nvim_open_win(buf, true, win_opts)

  local lines = { 'Project Picker', '' }
  for _, v in ipairs(find_project_dirs()) do
     table.insert(lines, v)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_win_set_cursor(win, {buffer_max_line, 0})
  set_mappings(buf)
end

return {
  open_window = open_window,
  close_window = close_window,
  move_cursor_up = move_cursor_up,
  open_project_current = open_project_current,
  open_project_tab = open_project_tab,
}
