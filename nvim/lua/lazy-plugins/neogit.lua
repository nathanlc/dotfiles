return {
	"NeogitOrg/neogit",
	config = function()
		require('neogit').setup({
			disable_hint = true,
			kind = 'replace',
			sections = {
				recent = {
					folded = false,
				},
				stashes = {
					folded = true,
				},
			},
		});

		-- Pre-fill commit message with branch name
		local autocmd_errors = {}
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup('nathanlc:Neogit', { clear = true }),
			pattern = "NeogitCommitMessage",
			callback = function()
				local function print_ticket_if_found(line)
					local ticket = string.match(line, '^%u+%-%d+')
					if ticket then
						vim.api.nvim_buf_set_lines(0, 0, 0, false, {ticket})
					end
				end

				vim.fn.jobstart({ 'git', 'branch', '--show-current' }, {
					stdout_buffered = true,
					on_stdout = function(_, data)
						if not data then
							return
						end

						if type(data) == 'string' then
							print_ticket_if_found(data)
						end

						if type(data) == 'table' then
							for _, v in ipairs(data) do
								print_ticket_if_found(v)
							end
						end
					end,
					on_stderr = function(_, data)
						if data then
							table.insert(autocmd_errors, data)
						end
					end,
					on_exit = function(_, _, _)
						vim.api.nvim_win_set_cursor(0, {1, 0})
						vim.api.nvim_command('normal $')

						if next(autocmd_errors) ~= nil then
							print(vim.inspect(autocmd_errors))
						end
					end
				})
			end
		})
	end
}
