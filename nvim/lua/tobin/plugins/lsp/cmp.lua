return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-cmdline',
    'FelipeLema/cmp-async-path',
    'L3MON4D3/LuaSnip',
    {
      'sirver/ultisnips',
      config = function()
        vim.g.UltiSnipsExpandTrigger = '<TAB>'
        vim.g.UltiSnipsJumpForwardTrigger = '<C-J>'
        vim.g.UltiSnipsJumpBackwardTrigger = '<C-K>'
        vim.g.ultisnips_javascript = {
          semi = 'never',
        }

        require('cmp_nvim_ultisnips').setup {}
      end,
    },
    'quangnguyen30192/cmp-nvim-ultisnips',
    'saadparwaiz1/cmp_luasnip',
    'js-everts/cmp-tailwind-colors',
  },
  config = function()
    local cmp = require 'cmp'
    local icons = require 'tobin.icons'

    local kind_icons = {
      Enum = icons.kind.Enum,
      File = icons.kind.File,
      Text = icons.kind.Text,
      Unit = icons.kind.Unit,
      Class = icons.kind.Class,
      Color = icons.kind.Color,
      Event = icons.kind.Event,
      Field = icons.kind.Field,
      Value = icons.kind.Value,
      Folder = icons.kind.Folder,
      Method = icons.kind.Method,
      Module = icons.kind.Module,
      Struct = icons.kind.Struct,
      Keyword = icons.kind.Keyword,
      Snippet = icons.kind.Snippet,
      Constant = icons.kind.Constant,
      Function = icons.kind.Function,
      Operator = icons.kind.Operator,
      Property = icons.kind.Property,
      Variable = icons.kind.Variable,
      Copilot = icons.lspType.Copilot,
      Interface = icons.kind.Interface,
      Reference = icons.kind.Reference,
      EnumMember = icons.kind.EnumMember,
      Constructor = icons.kind.Constructor,
      TypeParameter = icons.kind.TypeParameter,
    }

    local borderstyle = {
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
    }

    if vim.g.opts.minimal then
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }),
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
    end

    cmp.setup {
      snippet = {
        --- @param args cmp.SnippetExpansionParams
        expand = function(args)
          -- luasnip.lsp_expand(args.body)
          vim.fn['UltiSnips#Anon'](args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<TAB>'] = cmp.mapping.confirm { select = true },
        ['<ENTER>'] = cmp.mapping.confirm { select = true },
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, { 'i' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, { 'i' }),
        ['<CR>'] = cmp.mapping {
          --- @param fallback function
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm { select = true },
          c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
        },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        --- @param entry cmp.Entry
        --- @param vim_item vim.CompletedItem
        format = function(entry, vim_item)
          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
          return vim_item
        end,
      },
      preselect = cmp.PreselectMode.None,
      completion = { completeopt = 'noselect' },
      sources = cmp.config.sources {
        { name = 'async_path', priority = 2000 },
        { name = 'copilot', priority = 1000 },
        {
          name = 'nvim_lsp',
          priority = 800,
          entry_filter = function(entry)
            return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
          end,
        },
        {
          name = 'ultisnips',
          priority = 600,
          -- entry_filter = function(entry)
          --   return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
          -- ultisnip,
        },
        {
          name = 'buffer',
          priority = 400,
          entry_filter = function(entry)
            return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
          end,
        },
      },
      duplicates = {
        copilot = 1,
        nvim_lsp = 1,
        luasnip = 1,
        ultisnip = 1,
        buffer = 1,
        path = 1,
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        completion = borderstyle,
        documentation = borderstyle,
      },
      experimental = {
        ghost_text = false,
      },
    }

    -- require('luasnip/loaders/from_vscode').lazy_load { paths = vim.fn.stdpath 'config' .. '/snippets' }
  end,
}
