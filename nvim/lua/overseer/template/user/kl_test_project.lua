return {
  name = "Test project (KL)",
  tags = { "test_project" },
  builder = function()
    return {
      cmd = { "mutagen-compose", "exec", "-e", "RAILS_ENV=test", "-e", "DISABLE_SPRING=1", "mutagen-web", "bundle", "exec", "parallel_rspec", "-n", "40" },
      components = { "on_complete_notify", "on_complete_dispose" , "default" },
    }
  end,
  condition = {
    callback = function(search)
      local is_kl_dir = string.match(search.dir, "kings.landing")
      return is_kl_dir
    end
  },
}

