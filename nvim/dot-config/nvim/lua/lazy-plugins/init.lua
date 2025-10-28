return {
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  "jghauser/mkdir.nvim",
  "christoomey/vim-tmux-navigator",
  "tpope/vim-rsi",
  {
    "tpope/vim-rails",
    lazy = false
  },
  "tpope/vim-projectionist",
  "tpope/vim-abolish",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "andymass/vim-matchup",
  {
    "johmsalas/text-case.nvim",
    config = function() require("textcase").setup({}) end
  },
  {
    "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup({}) end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require('nvim-autopairs').setup() end,
  },
  {
    "stevearc/dressing.nvim",
    config = function() require("dressing").setup() end
  },
  {
    "ggandor/leap.nvim",
    config = function() require('leap').set_default_mappings() end,
  },
  {
    "nmac427/guess-indent.nvim",
    config = function() require('guess-indent').setup({}) end,
  },
  {
    "folke/zen-mode.nvim",
    config = function() require('zen-mode').setup() end
  },
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup({})
    end,
  },
  {
    "Wansmer/treesj",
    config = function()
      local tsj = require('treesj')
      tsj.setup({
        use_default_keymaps = false,
        max_join_length = 999,
      })
    end
  },
  {
    "jiaoshijie/undotree",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require('undotree').setup() end
  },
  {
    "yorickpeterse/nvim-pqf",
    config = function()
      require('pqf').setup({
        show_multiple_lines = true,
        max_filename_length = 49,
        filename_truncate_prefix = '…',
      })
    end
  },
  -- {
  --   "akinsho/flutter-tools.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "stevearc/dressing.nvim",
  --   },
  --   config = function()
  --     require("flutter-tools").setup({
  --       flutter_lookup_cmd = "asdf where flutter"
  --     })
  --   end,
  -- },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   config = function()
  --     local rt = require("rust-tools")
  --
  --     rt.setup({
  --       server = {
  --         on_attach = function(_, bufnr)
  --           -- Hover actions
  --           vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
  --           -- Code action groups
  --           vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
  --         end,
  --       },
  --     })
  --   end
  -- },
}
