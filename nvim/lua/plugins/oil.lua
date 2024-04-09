require('oil').setup({
  delete_to_trash = true,
  keymaps = {
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "<CMD>write<CR>",
    ["<C-x>"] = "actions.select_split",
    ["<C-r>"] = "actions.refresh",
    ["."] = "actions.open_terminal",
  },
  view_options = {
    show_hidden = true,
  }
})
