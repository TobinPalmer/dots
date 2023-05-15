return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'BufReadPre',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        separator_style = 'slant',
        hover = {
          enabled = true,
          delay = 0,
          reveal = { 'close' },
        },
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        numbers = function(opts)
          return string.format('%s', opts.ordinal)
        end,

        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon',
        },
      },
    }
  end,
}
