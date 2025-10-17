return {
  name = "Check (gradle)",
  tags = { "check" },
  builder = function()
    return {
      cmd = { "gradle", "wrapper", "check" },
      components = {
        "on_complete_notify",
        "on_complete_dispose",
        {
          "on_output_parse", parser = {
            diagnostics = {
              -- {"skip_until", "^.*:checkstyleMain$"},
              {"loop",
                {"extract", "^(%[.*%]) (%[.*%]) (.*):([0-9]+): (.*) (%[.*%])$", "_", "_", "filename", "lnum",  "_", "text"}
              },
              -- {"skip_until", "^.*:checkstyleTest$"},
              -- {"loop",
              --   {"extract", "^(%[.*%]) (%[.*%]) (.*):([0-9]+): (.*) (%[.*%])$", "_", "_", "filename", "lnum",  "_", "text"}
              -- },
            }
          }
        },
        "on_result_diagnostics",
        "default"
      },
    }
  end,
  condition = {
    callback = function()
      local is_java_file = vim.fn.expand("%:e") == 'java'
      return is_java_file
    end
  },
}

