require("luasnip.session.snippet_collection").clear_snippets("ruby")

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
-- local f = ls.function_node
-- local t = ls.text_node


local fmt = require("luasnip.extras.fmt").fmt

-- local function copy(args)
-- 	return args[1]
-- end

ls.add_snippets(
  "ruby",
  {
    s("imethod", fmt(
        [[
        def {}
            {}
        end

        ]],
        { i(1, "method"), i(0) }
      )
    ),
  },
  {
    -- type = "autosnippets",
  }
)
