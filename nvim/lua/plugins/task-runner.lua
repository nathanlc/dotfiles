require('overseer').setup({
  task_list = {
    min_width = {60, 0.2}
  },
  templates = {
    "builtin",
    "user.gradle_test_file",
    "user.gradle_test_project",
    "user.gradle_check",
    "user.kl_test_file",
  },
})
