local Path = require('plenary.path')

return {
  name = "Test backend file (KL)",
  tags = { "test_file" },
  builder = function()
    local file_path_abs = Path:new(vim.fn.expand("%:p"))
    local file_path_rel = file_path_abs:normalize(vim.fn.getcwd())

    return {
      cmd = { "docker", "compose", "exec", "web", "bin/rspec", file_path_rel },
      components = { "on_complete_notify", "on_complete_dispose", "default" },
    }
  end,
  condition = {
    dir = { "/Users/nathan/sandbox/glooko/kings-landing" },
    filetype = { "ruby" },
  },
}
