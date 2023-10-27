require('oil').setup({
  keymaps = {
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["<C-r>"] = "actions.refresh",
  },
  view_options = {
    show_hidden = true,
  }
})
