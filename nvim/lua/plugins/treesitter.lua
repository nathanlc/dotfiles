require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    ignore_install = { "phpdoc" },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
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
    },
})

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
