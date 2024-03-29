local telescope = require('telescope')

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,          -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,   -- override the file sorter
      case_mode = "smart_case",    -- or "ignore_case" or "respect_case"
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<A-f>"] = { "<S-Right>", type = "command" },
        ["<C-f>"] = { "<Right>", type = "command" },
        ["<C-d>"] = { "<Del>", type = "command" },
      },
    },
    file_ignore_patterns = {
      "%.class",
      "^.git/",
    },
    cache_picker = {
      num_pickers = 15,
    },
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        height = 0.95
      }
    }
  },
  pickers = {
    -- lsp_references = {
    --   theme = "cursor"
    -- }
  }
})

telescope.load_extension('fzf')
