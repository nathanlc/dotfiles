return {
  name = "Test file (gradle)",
  tags = { "test_file" },
  builder = function()
    local file_without_extension = vim.fn.expand("%:t:r")
    return {
      cmd = { "gradle", "wrapper", "test", "--tests", file_without_extension },
      components = { "on_complete_notify", "on_complete_dispose" , "default" },
    }
  end,
  condition = {
    callback = function()
      local is_test_file = string.match(vim.fn.expand("%:t"), "Test")
      local is_java_file = vim.fn.expand("%:e") == 'java'
      return is_java_file and is_test_file
    end
  },
}
