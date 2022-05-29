require'lspconfig'.sqls.setup{
    on_attach = function(client)
        client.resolved_capabilities.execute_command = true

        require'sqls'.setup{}
    end
}

nvim_lsp.sqls.setup({ -- SQL - go get github.com/lighttiger2505/sqls
    on_attach = on_attach,
})

