local Path = require('plenary.path')
local Buffer = require('utils.buffer')
local String = require('utils.string')
local Table = require('utils.table')
local Project = require('plugins.project')
local Section = require('plugins.home.section')

local M = {}

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

local function section_lines(section)
  local title = section.title .. ' (' .. section.mark .. ')'

  return Table.concat({
    { title },
    section.lines,
    { '' },
  })
end

local function draw(window, bufnr, sections)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    print('Home buffer no longer exists.')
    return
  end

  Buffer.set_options(bufnr, {
    bufhidden = 'wipe',
    filetype = 'nathanlc_home',
    modifiable = true,
  })

  local title_lines = {
    'Home',
    '',
  }

  local lines = Table.concat({
    title_lines,
    unpack(Table.map(section_lines, sections))
  })
  local padded_lines = Table.map(function(l)
    if l == '' then
      return l
    end
    return '  ' .. l
  end, lines)

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, padded_lines)
  Buffer.set_options(bufnr, {
    modifiable = false,
  })

  local lines_count = #title_lines
  for _, section in ipairs(sections) do
    vim.api.nvim_buf_set_mark(
      bufnr,
      section.mark,
      lines_count + 2,
      1,
      {}
    )
    lines_count = lines_count + #section.lines + 2 -- 2 lines for title and padding
  end

  vim.api.nvim_set_current_win(window)
  vim.api.nvim_set_current_buf(bufnr)

  local map_opts = { nowait = true, noremap = true, silent = true, }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', [[<Cmd>lua require('plugins.home').on_select_current()<CR>]], map_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-t>', [[<Cmd>lua require('plugins.home').on_select_tab()<CR>]], map_opts)
end

function M.home()
  local window = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_create_buf(false, true)

  local sync_sections = {
    Section.recent_projects(),
    Section.old_files(),
  }
  local all_sections = sync_sections
  local function add_section(section)
    table.insert(all_sections, section)
    vim.schedule(function()
      draw(window, bufnr, all_sections)
    end)
  end

  draw(window, bufnr, sync_sections)
  local first_section = all_sections[1]
  vim.api.nvim_command("normal '" .. first_section['mark'])
  Section.prs_to_review(add_section)
  Section.prs_ongoing(add_section)
end

return M
