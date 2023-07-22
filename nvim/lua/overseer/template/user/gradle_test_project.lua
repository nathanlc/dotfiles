return {
  name = "Test project (gradle)",
  tags = { "test_project" },
  builder = function()
    return {
      cmd = { "gradle", "wrapper", "test" },
      components = { "on_complete_notify", "on_complete_dispose" , "default" },
    }
  end,
  condition = {
    callback = function()
      local is_java_file = vim.fn.expand("%:e") == 'java'
      return is_java_file
    end
  },
}

