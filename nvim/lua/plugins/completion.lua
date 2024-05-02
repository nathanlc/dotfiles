-- vim.o.completeopt = "menu,menuone,noselect"
vim.o.completeopt = "menuone,noselect"

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      -- mode = 'symbol',
      -- menu = {
      --   buffer = "[buf]",
      --   nvim_lsp = "[LSP]",
      --   nvim_lua = "[lua]",
      --   path = "[path]",
      --   luasnip = "[snip]",
      -- }
    })
  }
})

-- `/` cmdline setup.
-- cmp.setup.cmdline({'/', '?'}, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' },
--     { name = 'cmdline_history' },
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
local function delay(fn, time)
    local timer = vim.loop.new_timer()
    timer:start(time, 0, vim.schedule_wrap(function()
        fn()
        timer:stop()
    end))
end

local cmd_mapping = cmp.mapping.preset.cmdline()
local cmd_mapping_overwrite = {
      ['<Tab>'] = {
        c = function()
            if vim.api.nvim_get_mode().mode == "c" and cmp.get_selected_entry() == nil then
                local text = vim.fn.getcmdline()
                local expanded = vim.fn.expandcmd(text)
                if expanded ~= text then
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, true, true) .. expanded, "n", false)
                    -- triggering right away won't work, need to wait a cycle
                    delay(cmp.complete, 0)
                elseif cmp.visible() then
                    cmp.select_next_item()
                else
                    cmp.complete()
                end
            else
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    cmp.complete()
                end
            end -- in the real mapping there are other elseif clauses
        end,
    }
}

for k, v in pairs(cmd_mapping_overwrite) do
    cmd_mapping[k] = v
end

cmp.setup.cmdline(':', {
  mapping = cmd_mapping,
  sources = cmp.config.sources({
    {
      name = 'path',
      option = {
        trailing_slash = true
      }
    },
    { name = 'cmdline_history' },
  }, {
    { name = 'cmdline' }
  })
})

-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.source({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   }),
--   matching = { disallow_symbol_nonprefix_matching = false }
-- })
