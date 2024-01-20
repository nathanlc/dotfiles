local Path = require('plenary.path')

return {
  name = "Test file (KL)",
  tags = { "test_file" },
  builder = function()
    local file_path_abs = Path:new(vim.fn.expand("%:p"))
    local file_path_rel = file_path_abs:normalize(vim.fn.getcwd())

    return {
      cmd = { "mutagen-compose", "exec", "-e", "RAILS_ENV=test", "-e", "DISABLE_SPRING=1", "mutagen-web", "bundle", "exec", "rspec", file_path_rel },
      components = { "on_complete_notify", "on_complete_dispose" , "default" },
    }
  end,
  condition = {
    callback = function(search)
      local is_kl_dir = string.match(search.dir, "kings.landing")
      local is_test_file = string.match(vim.fn.expand("%:t"), "_spec.rb")
      return is_kl_dir and is_test_file
    end
  },
}

