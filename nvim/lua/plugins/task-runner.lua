local overseer = require('overseer')

overseer.setup({
  task_list = {
    min_width = {60, 0.2}
  },
  templates = {
    "builtin",
    "user.gradle_test_file",
    "user.gradle_test_project",
    "user.gradle_check",
    "user.kl_test_file",
    "user.azr_test_file",
  },
})

local M = {}

function M.restart_latest_task()
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end

return M
