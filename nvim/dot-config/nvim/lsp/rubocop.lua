---@type vim.lsp.Config
return {
  cmd = { 'mise', 'exec', '--', 'ruby-lsp' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
}
