local packer = require('packer')

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim' -- Mostly lua helper functions
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter-context', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'RRethy/nvim-treesitter-endwise', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'windwp/nvim-ts-autotag', requires = 'nvim-treesitter/nvim-treesitter' }
  use 'kyazdani42/nvim-web-devicons'
  use {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup()
    end
  }
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-jdtls' -- Lsp for Java. Download java language server jdtls from https://download.eclipse.org/jdtls/snapshots/?d and extract in chosen path
  -- nvim-cmp start Auto completion compatible with LSP
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'dmitmel/cmp-cmdline-history'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'
  -- nvim-cmp end
  -- use 'gelguy/wilder.nvim'
  use {
    'L3MON4D3/LuaSnip',
    tag = "v2.*",
    requires = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    },
    run = "make install_jsregexp"
  }
  use 'ggandor/leap.nvim'
  use 'jghauser/mkdir.nvim'
  use {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup({}) end,
  }
  -- File explorer start
  -- use 'tpope/vim-vinegar'
  use 'stevearc/oil.nvim'
  -- File explorer end
  use 'andymass/vim-matchup'
  use 'stevearc/overseer.nvim' -- Task runner
  -- Telescope start
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }
  use 'BurntSushi/ripgrep'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- Telescope end
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-rsi'
  use 'tpope/vim-dispatch' -- TODO: remove?
  -- Themes start
  -- use 'navarasu/onedark.nvim'
  use 'neanias/everforest-nvim'
  -- Themes end
  use 'nanotee/sqls.nvim'
  use 'tpope/vim-dadbod'
  use 'tpope/vim-rails'
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup() end,
  }
  use {
    "stevearc/dressing.nvim",
    config = function() require("dressing").setup() end
  }
  -- use {
  --   "folke/noice.nvim",
  --   requires = { "MunifTanjim/nui.nvim" },
  -- }
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-projectionist'
  use 'kylechui/nvim-surround'
  use 'tpope/vim-abolish' -- Smartcase string substitutions
  -- Neogit start
  use 'NeogitOrg/neogit'
  -- Neogit end
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'nvim-orgmode/orgmode' -- TODO: remove?
  -- Debugger start
  use 'mfussenegger/nvim-dap'
  use {
    "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  }
  -- Debugger end
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'johmsalas/text-case.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end
  }
  use "zbirenbaum/copilot.lua"
  -- Flutter start
  use {
    'akinsho/flutter-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
  }
  -- Flutter end
  -- Opener start
  use { 'ofirgall/open.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'ofirgall/open-jira.nvim'
  -- Opener end
  -- Rust start
  use 'simrat39/rust-tools.nvim'
  -- Rust end
  use {
    "Wansmer/treesj",
    config = function()
      local tsj = require('treesj')
      tsj.setup({
        use_default_keymaps = false,
        max_join_length = 999,
      })
    end
  }
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "antoinemadec/FixCursorHold.nvim"
    }
  }
  use {
    'LhKipp/nvim-nu',
    config = function()
      require('nu').setup({
        use_lsp_features = true
      })
    end
  }
  use {
    "jiaoshijie/undotree",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  }

  packer.sync()
end)
