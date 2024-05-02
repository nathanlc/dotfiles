return {
  name = "Test file (gradle)",
  tags = { "test_file" },
  builder = function()
    local file_without_extension = vim.fn.expand("%:t:r")
    -- Detect if this is monorepo or not. If monorepo, instead of `test`,
    -- task should be A22010-omnipod_service:test for instance
    local file_path_without_extension = vim.fn.expand("%:r")
    local base_dir = file_path_without_extension:match("([^/]*)/.*")
    local test_task = "test"
    if base_dir ~= "src" and base_dir ~= "service" then
      test_task = base_dir .. ":test"
    end
    return {
      cmd = { "gradle", "wrapper", test_task, "--tests", file_without_extension },
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
