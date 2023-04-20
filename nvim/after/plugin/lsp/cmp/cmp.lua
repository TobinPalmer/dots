local cmp = require 'cmp'
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({

    { name = 'cmp_git' },
  }, { { name = 'buffer' } }),
})

cmp.setup {
  sources = cmp.config.sources({
    { name = 'copilot' },
    {
      name = 'nvim_lsp',
      entry_filter = function(entry, _)
        return require('cmp').lsp.CompletionItemKind.Text ~= entry:get_kind()
      end,
    },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.exact,
      function(entry1, entry2)
        local kind1 = entry1:get_kind()
        local kind2 = entry2:get_kind()
        if kind1 < kind2 then
          return true
        end
      end,
    },
  },
  formatting = {
    format = require('lspkind').cmp_format {
      mode = 'symbol',
      maxwidth = 50,
    },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<TAB>'] = cmp.mapping.confirm { select = true },
    ['<ENTER>'] = cmp.mapping.confirm { select = true },
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, { 'i' }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, { 'i' }),
  },
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

cmp.event:on('menu_opened', function()
  vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on('menu_closed', function()
  vim.b.copilot_suggestion_hidden = false
end)
