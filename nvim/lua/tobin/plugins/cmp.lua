return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'js-everts/cmp-tailwind-colors',
  },
  config = function()
    local luasnip = require 'luasnip'
    local cmp = require 'cmp'
    local icons = require 'tobin.icons'

    local kind_icons = {
      Text = icons.kind.Text,
      Method = icons.kind.Method,
      Function = icons.kind.Function,
      Constructor = icons.kind.Constructor,
      Field = icons.kind.Field,
      Variable = icons.kind.Variable,
      Class = icons.kind.Class,
      Interface = icons.kind.Interface,
      Module = icons.kind.Module,
      Property = icons.kind.Property,
      Unit = icons.kind.Unit,
      Value = icons.kind.Value,
      Enum = icons.kind.Enum,
      Keyword = icons.kind.Keyword,
      Snippet = icons.kind.Snippet,
      Color = icons.kind.Color,
      File = icons.kind.File,
      Reference = icons.kind.Reference,
      Folder = icons.kind.Folder,
      EnumMember = icons.kind.EnumMember,
      Constant = icons.kind.Constant,
      Struct = icons.kind.Struct,
      Event = icons.kind.Event,
      Operator = icons.kind.Operator,
      TypeParameter = icons.kind.TypeParameter,
    }

    local borderstyle = {
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<TAB>'] = cmp.mapping.confirm { select = true },
        ['<ENTER>'] = cmp.mapping.confirm { select = true },
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, { 'i' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, { 'i' }),
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          vim_item.menu = ({
            -- Todo: icons
            copilot = '[Copilot]',
            nvim_lsp = '[LSP]',
            luasnip = '[Snip]',
            buffer = '[Buff]',
            path = '[Path]',
          })[entry.source.name]

          -- for tailwind colors
          if vim_item.kind == 'Color' then
            vim_item = require('cmp-tailwind-colors').format(entry, vim_item)

            if vim_item.kind ~= 'Color' then
              vim_item.menu = 'Color'
              return vim_item
            end
          end

          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
          return vim_item
        end,
      },
      preselect = cmp.PreselectMode.None,
      completion = { completeopt = 'noselect' },
      sources = cmp.config.sources {
        { name = 'copilot', priority = 1000 },
        { name = 'nvim_lsp', priority = 800 },
        { name = 'luasnip', priority = 600 },
        { name = 'buffer', priority = 400 },
        { name = 'path', priority = 200 },
      },
      duplicates = {
        copilot = 1,
        nvim_lsp = 1,
        luasnip = 1,
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
        native_menu = false,
      },
    }

    -- require("luasnip/loaders/from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
  end,
}
