local cmp_nvim_lsp = require('cmp_nvim_lsp')

local M = {}

local on_attach = function(client, bufnr)
    local bufopts = { silent = true, buffer = bufnr }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', [[<Cmd>lua require('telescope.builtin').lsp_definitions({initial_mode = 'normal'})<CR>]], bufopts)
    vim.keymap.set('n', 'gD', ':vsplit<CR><Cmd>lua require("telescope.builtin").lsp_definitions()<CR>', bufopts)
    vim.keymap.set('n', 'gi', [[<Cmd>lua require('telescope.builtin').lsp_implementations({initial_mode = 'normal'})<CR>]], bufopts)
    vim.keymap.set('n', 'gr', [[<Cmd>lua require('telescope.builtin').lsp_references({initial_mode = 'normal'})<CR>]], bufopts)
    vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<leader>Wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- vim.keymap.set('n', '<leader>Wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.keymap.set('n', '<leader>Wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.keymap.set('n', '<leader>rb', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>=", vim.lsp.buf.formatting, bufopts)
    vim.keymap.set("n", "<leader>I", [[<Cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()[1].resolved_capabilities))<CR>]], bufopts)
    vim.keymap.set("n", "<leader>pjs", [[<Cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]], bufopts)
    vim.keymap.set("n", "<leader>pjc", [[<Cmd>lua require('telescope.builtin').lsp_workspace_symbols({default_text = ':class: '})<CR>]], bufopts)
    vim.keymap.set("n", "<leader>pjf", [[<Cmd>lua require('telescope.builtin').lsp_workspace_symbols({default_text = ':function: '})<CR>]], bufopts)
    vim.keymap.set("n", "<leader>pjm", [[<Cmd>lua require('telescope.builtin').lsp_workspace_symbols({default_text = ':method: '})<CR>]], bufopts)
end

M.on_attach = on_attach
M.capabilities = cmp_nvim_lsp.default_capabilities()

return M
