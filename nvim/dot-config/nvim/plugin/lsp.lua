vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities({
    -- textDocument = {
    --   semanticTokens = {
    --     multilineTokenSupport = true,
    --   }
    -- }
  }),
  root_markers = { '.git' },
})

vim.lsp.enable({
  "lua_ls",
  "rubocop",
  "ruby_lsp",
  "ts_ls",
})
