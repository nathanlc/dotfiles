local Path = require('plenary.path')

---@type overseer.TemplateFileDefinition
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
    dir = {"/Users/nathan/sandbox/glooko/A06103-analyzer_server"},
    filetype = { "python" },
  },
}

