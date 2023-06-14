local dependencies = {}
if vim.g.opts.use_icons then
  dependencies = { 'nvim-tree/nvim-web-devicons' }
end
return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'BufReadPre',
  keys = {
    { '<Leader>bb', '<CMD>BufferLineCyclePrev<CR>', desc = 'Go To Previous Buffer' },
    { '<Leader>bh', '<CMD>BufferLineMovePrev<CR>', desc = 'Close Current Buffer' },
    { '<Leader>bl', '<CMD>BufferLineMoveNext<CR>', desc = 'Close Current Buffer' },
    { '<Leader>bn', '<CMD>BufferLineCycleNext<CR>', desc = 'Go To Next Buffer' },
    { '<leader>b1', '<CMD>lua require("bufferline").go_to(1, true)<CR>', desc = 'Go to buffer 1' },
    { '<leader>b2', '<CMD>lua require("bufferline").go_to(2, true)<CR>', desc = 'Go to buffer 2' },
    { '<leader>b3', '<CMD>lua require("bufferline").go_to(3, true)<CR>', desc = 'Go to buffer 3' },
    { '<leader>b4', '<CMD>lua require("bufferline").go_to(4, true)<CR>', desc = 'Go to buffer 4' },
    { '<leader>b5', '<CMD>lua require("bufferline").go_to(5, true)<CR>', desc = 'Go to buffer 5' },
    { '<leader>b6', '<CMD>lua require("bufferline").go_to(6, true)<CR>', desc = 'Go to buffer 6' },
    { '<leader>b7', '<CMD>lua require("bufferline").go_to(7, true)<CR>', desc = 'Go to buffer 7' },
    { '<leader>b8', '<CMD>lua require("bufferline").go_to(8, true)<CR>', desc = 'Go to buffer 8' },
    { '<leader>b9', '<CMD>lua require("bufferline").go_to(9, true)<CR>', desc = 'Go to buffer 9' },
    { '<leader>b$', '<CMD>lua require("bufferline").go_to(-1, true)<CR>', desc = 'Go to buffer $' },
  },
  dependencies = dependencies,
  config = function()
    local icons = require 'tobin.icons'
    require('bufferline').setup {
      highlights = {
        background = {
          fg = '#70747f',
        },
        fill = {
          bg = '#24283b',
          fg = '#24283b',
        },
        separator_selected = {
          fg = '#24283b',
        },
        separator_visible = {
          fg = '#24283b',
        },
        separator = {
          fg = '#24283b',
        },
      },
      options = {
        separator_style = vim.g.opts.bufferline.style,
        hover = {
          enabled = true,
          delay = 0,
          reveal = { 'close' },
        },
        show_buffer_icons = vim.g.opts.use_icons,
        buffer_close_icon = icons.ui.Close,
        modified_icon = icons.ui.Pencil,
        close_icon = icons.ui.Close,
        left_trunc_marker = icons.ui.ChevronLeft,
        right_trunc_marker = icons.ui.ChevronRight,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, _, _)
          local icon
          if vim.g.opts.use_icons then
            icon = level:match 'error' and icons.diagnostics.Error or icons.diagnostics.Warning
          else
            icon = level:match 'error' and icons.diagnostics.Error .. ' ' or icons.diagnostics.Warning .. ' '
          end
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
