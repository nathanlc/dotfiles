local packer = require('packer')

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim' -- Mostly lua helper functions
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter-context', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'RRethy/nvim-treesitter-endwise', requires = 'nvim-treesitter/nvim-treesitter' }
  use 'kyazdani42/nvim-web-devicons'
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-jdtls' -- Lsp for Java. Download java language server jdtls from https://download.eclipse.org/jdtls/snapshots/?d and extract in chosen path
  use 'ray-x/lsp_signature.nvim'
  -- nvim-cmp start Auto completion compatible with LSP
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'
  -- nvim-cmp end
  use {'L3MON4D3/LuaSnip', requires = 'saadparwaiz1/cmp_luasnip'}
  use 'rafamadriz/friendly-snippets'
  use 'nvim-lua/popup.nvim'
  use 'ggandor/leap.nvim'
  use 'jghauser/mkdir.nvim'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-vinegar'
  use 'andymass/vim-matchup'
  use 'stevearc/overseer.nvim' -- Task runner
  -- Telescope start
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'BurntSushi/ripgrep'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- Telescope end
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-rsi'
  use 'tpope/vim-dispatch'
  -- Themes start
  -- use 'navarasu/onedark.nvim'
  use 'neanias/everforest-nvim'
  -- Themes end
  use 'nanotee/sqls.nvim'
  use 'tpope/vim-dadbod'
  use 'tpope/vim-rails'
  use 'jiangmiao/auto-pairs'
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-projectionist'
  use 'kylechui/nvim-surround'
  use 'tpope/vim-abolish' -- Smartcase string substitutions
  -- Neogit start
  use 'NeogitOrg/neogit'
  -- Neogit end
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'nvim-orgmode/orgmode'
  -- Debugger start
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  -- Debugger end
  use '/Users/nathan/sandbox/mine/himalaya/vim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'johmsalas/text-case.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  }
  use "zbirenbaum/copilot.lua"
  -- Opener start
  use { 'ofirgall/open.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'ofirgall/open-jira.nvim'
  -- Opener end
  -- Rust start
  use 'simrat39/rust-tools.nvim'
  -- Rust end
  use {
  "nvim-neotest/neotest",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "antoinemadec/FixCursorHold.nvim"
  }
}

  packer.sync()
end)
