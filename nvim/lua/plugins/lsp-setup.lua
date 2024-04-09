local nvim_lsp = require('lspconfig')
local lsp_config = require('plugins/lsp-config')
local lsp_signature = require('lsp_signature')

-- See ./lua/ftplugin/java.lua
nvim_lsp.intelephense.setup(lsp_config) -- PHP - npm install -g intelephense
nvim_lsp.tsserver.setup(lsp_config) -- JavaScript - npm install -g typescript typescript-language-server
nvim_lsp.elmls.setup(lsp_config) -- Elm - npm install -g @elm-tooling/elm-language-server elm-format
nvim_lsp.gopls.setup(lsp_config) -- Go - cd /tmp && GO111MODULE=on go get golang.org/x/tools/gopls@latest
nvim_lsp.pyright.setup(lsp_config) -- Python - npm install -g pyright
nvim_lsp.solargraph.setup(lsp_config) -- Ruby - gem install solargraph
nvim_lsp.sqlls.setup(lsp_config) -- See https://github.com/joe-re/sql-language-server for config. Installed via Mason.
nvim_lsp.lua_ls.setup({ -- brew install lua-language-server
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
nvim_lsp.nushell.setup(lsp_config) -- language server built-in nushell

lsp_signature.setup({
  bind = true,
  handler_opts = {
    border = "rounded"
  }
})
