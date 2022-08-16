require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  ignore_install = { "phpdoc" },
  highlight = {
    enable = true,
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
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['aP'] = '@parameter.outer',
        ['iP'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumgs = true,
      goto_previous_start = {
        ['(('] = '@function.outer',
      },
      goto_next_start = {
        ['))'] = '@function.outer',
      },
    }
  },
  endwise = {
    enable = true,
  },
})

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

require('treesitter-context').setup{
    enable = true,
    max_lines = 0,
    trim_scope = 'outer',
    patterns = {
        default = {
            -- 'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
    },
}
