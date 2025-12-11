---@type vim.lsp.Config
return {
  cmd = { 'mise', 'exec', '--', 'rubocop', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
}
