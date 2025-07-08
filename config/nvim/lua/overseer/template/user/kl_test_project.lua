return {
  name = "Test Project (KL)",
  tags = { "test_project" },
  builder = function()
    return {
      cmd = { "docker", "compose", "exec", "web", "zsh", "-ic", "bin/rake", "parallel:test rspec" },
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

