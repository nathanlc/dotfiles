-- Load custom tree-sitter grammar for org filetype
-- require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
-- require'nvim-treesitter.configs'.setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
    -- highlight = {
        -- enable = true,
        -- additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
    -- },
    -- ensure_installed = {'org'}, -- Or run :TSUpdate org
    -- notification = {}, -- Check https://github.com/nvim-orgmode/orgmode/blob/master/DOCS.md#notifications-experimental
-- }

-- require('orgmode').setup({
    -- org_agenda_files = {'~/org/*'},
    -- org_default_notes_file = '~/org/notes.org',
-- })
