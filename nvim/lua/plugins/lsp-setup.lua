local nvim_lsp = require('lspconfig')
local lsp_config = require('plugins/lsp-config')

-- See ./lua/ftplugin/java.lua
nvim_lsp.intelephense.setup(lsp_config) -- PHP - npm install -g intelephense
nvim_lsp.tsserver.setup(lsp_config) -- JavaScript - npm install -g typescript typescript-language-server
nvim_lsp.elmls.setup(lsp_config) -- Elm - npm install -g @elm-tooling/elm-language-server elm-format
nvim_lsp.gopls.setup(lsp_config) -- Go - cd /tmp && GO111MODULE=on go get golang.org/x/tools/gopls@latest
nvim_lsp.pyright.setup(lsp_config) -- Python - npm install -g pyright
nvim_lsp.sqls.setup({ -- SQL - go get github.com/lighttiger2505/sqls
    capabilities = lsp_config.capabilities,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.execute_command = true
        lsp_config.on_attach(client, bufnr)
        require'sqls'.setup{}
    end,
    settings = {
        sqls = {
            lowercaseKeywords = false,
            connections = {
                {
                    driver = 'mysql',
                    dataSourceName = 'root@tcp(127.0.0.1:3306)/diasend'
                }
            }
        }
    }
})
nvim_lsp.sumneko_lua.setup({ -- brew install lua-language-server
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
                globals = {'vim', 'hs'},
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
