local M = {};

local global_ignore_paths = {
    'node_modules',
    'bower_components',
    'elm_stuff',
    '.git',
}

local relative_ignore_paths = {
    './vendor',
}

local function concat_ignores()
    local string = "";

    for _, g in ipairs(global_ignore_paths) do
        string = string .. ' -not \\( -name ' .. g .. ' -prune \\)'
    end

    for _, r in ipairs(relative_ignore_paths) do
        string = string .. ' -not \\( -path ' .. r .. ' -prune \\)'
    end

    return string;
end

local function prompt(label)
    vim.fn.inputsave()
    local user_value = vim.fn.input(label.. ' ')
    vim.fn.inputrestore()
    vim.cmd('normal: <Esc>')

    return user_value
end

local function auto_close_quickfix()
    local quickfix_length = vim.api.nvim_eval("getqflist({'size' : 0}).size")

    if quickfix_length < 2 then
        vim.cmd('cclose')
    end
end

function M.find_files()
    local query = prompt('Find files:')
    local command = 'fd . ' .. concat_ignores() .. ' -type f -iname "' .. query .. '.*"'

    local error_format = '%f'

    -- Instead of using cexpr below, it should be possible to use cfile.
    vim.cmd('set errorformat^=' .. error_format)
    vim.cmd("silent cexpr systemlist('" .. command .. "')")
    vim.cmd('set errorformat-=' .. error_format)

    auto_close_quickfix()
end

return M
