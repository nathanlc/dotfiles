local M = {}

local cmp_capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
	cmp_capabilities = require("cmp_nvim_lsp").default_capabilities
end

M.get = function()
	return vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		cmp_capabilities())
end

return M
