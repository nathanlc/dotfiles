if vim.g.neovide then
  -- -- Helper function for transparency formatting
  -- local alpha = function()
  --   return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  -- end
  -- -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  -- vim.g.neovide_transparency = 0.0
  -- vim.g.transparency = 0.99
  -- vim.g.neovide_background_color = "#5A5A5A" .. alpha()
  -- vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_cursor_animation_length = 0.01
  -- vim.o.guifont = "Source Code Pro:h14" -- text below applies for VimScript
  vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
  vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
  vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
  vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})
  vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', {noremap = true})
  vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', {noremap = true})
  vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', {noremap = true})
  vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', {noremap = true})

  vim.keymap.set({'i'}, '<D-v>', '<C-r>+', {silent = true})
end
