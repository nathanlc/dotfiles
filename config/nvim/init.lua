-- Must be run before lazy.
vim.g.mapleader = ' '
vim.g.maplocalleader = "!"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(
  {import = 'lazy-plugins'},
  {
    change_detection = {
      notify = false,
    },
  }
)

require("plugins.win-hoarder-layout").setup({
  expand_horizontal_direction = "right",
})
