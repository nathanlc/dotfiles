local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  ignore_install = { "phpdoc" },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true,
    disable = {}
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['ib'] = '@block.inner',
        ['ab'] = '@block.outer',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_previous_start = {
        ['(c'] = '@class.outer',
        ['(('] = '@function.outer',
        ['(l'] = '@loop.outer',
        ['(i'] = '@conditional.outer',
        ['(a'] = '@parameter.outer',
      },
      goto_next_start = {
        [')c'] = '@class.outer',
        ['))'] = '@function.outer',
        [')l'] = '@loop.outer',
        [')i'] = '@conditional.outer',
        [')a'] = '@parameter.outer',
      },
    }
  },
  autotag = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
})

vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
