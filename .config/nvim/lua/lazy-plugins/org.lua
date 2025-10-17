return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/Dropbox/org/**/*',
      org_default_notes_file = '~/Dropbox/org/capture.org',
      org_todo_keywords = {'TODO(t)', 'NEXT(n)', 'WIP(i)', 'WAITING(w)', '|', 'DONE(d)'}
    })
  end,
}
