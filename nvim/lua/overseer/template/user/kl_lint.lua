local Job = require('plenary.job')

return {
  name = "Lint (KL)",
  tags = { "check" },
  builder = function()
		local diff_files = Job:new({
			"git",
			"diff",
			"main",
			"--name-only",
		}):sync()
    -- The table above can contain files that have been deleted in the feature branch and should be ignored.
    -- local existing_ruby_files = {}
    local existing_js_files = {}
    for _, file in ipairs(diff_files) do
      -- if vim.fn.filereadable(file) == 1 and file:match('rb$') then
      --   table.insert(existing_ruby_files, file)
      -- end
      if vim.fn.filereadable(file) == 1 then
        if file:match('js$') or file:match('jsx$') or file:match('ts$') or file:match('tsx$') then
          local file_wo_prefix = file:gsub('^client/', '')
          table.insert(existing_js_files, file_wo_prefix)
        end
      end
    end

		return {
			-- cmd = { "mutagen-compose", "exec", "mutagen-web", "bundle", "exec", "rubocop", unpack(existing_ruby_files)},
			cmd = { "mutagen-compose", "exec", "mutagen-react", "./node_modules/.bin/eslint", unpack(existing_js_files)},
			components = {
        "on_complete_notify",
        "on_complete_dispose",
        {
          "on_output_parse", parser = {
            -- diagnostics = {
            --   {"skip_until", "^Offenses:$"},
            --   {"skip_lines", 1},
            --   {"loop",
            --     {"sequence",
            --       {"extract", "^([^:]+):([0-9]+):([0-9]+): (.*)$", "filename", "lnum", "col", "text"},
            --       {"skip_lines", 2},
            --     }
            --   },
            -- }
            diagnostics = {
              {"skip_lines", 1},
              {"loop",
                {"sequence",
                  {"extract", { append = false }, "^/app/([^ ]+)$", "filename"},
                  {"set_defaults", {},
                    {"loop", {"extract", {}, "^  (%d+):(%d+)  ([^ ]+)  (.*)$", "lnum", "col", "type", "text"}}
                  },
                  {"skip_lines", 1},
                }
              },
            }
          }
        },
        "on_result_diagnostics_quickfix",
        "default",
      },
		}
  end,
  condition = {
    callback = function(search)
      local is_kl_dir = string.match(search.dir, "kings.landing")
      return is_kl_dir
    end
  },
}


