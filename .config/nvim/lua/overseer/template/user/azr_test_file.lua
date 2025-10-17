local Path = require('plenary.path')

return {
  name = "Test file (AZR)",
  tags = { "test_file" },
  builder = function()
    local file_path_abs = Path:new(vim.fn.expand("%:p"))
    local file_path_rel = file_path_abs:normalize(vim.fn.getcwd())

    print("file_path_rel: " ..file_path_rel)

    return {
      cmd = { "docker", "compose", "exec", "analyzer", "./py.test", "-v", file_path_rel },
      components = { "on_complete_notify", "on_complete_dispose" , "default" },
    }
  end,
  condition = {
    callback = function(search)
      local is_azr_dir = string.match(search.dir, "analyzer_server")
      local is_test_file = string.match(vim.fn.expand("%:t"), "test_.*.py")

      return is_azr_dir and is_test_file
    end
  },
}

