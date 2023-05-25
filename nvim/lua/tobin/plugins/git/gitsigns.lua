return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPost',
  keys = {
    { 'gn', '<cmd>Gitsigns next_hunk<CR>' },
    { 'gN', '<cmd>Gitsigns prev_hunk<CR>' },
    { '<leader>gb', '<cmd>Gitsigns blame_line<CR>' },
    { '<leader>gl', '<cmd>Gitsigns toggle_current_line_blame<CR>' },
    { '<leader>gw', '<cmd>Gitsigns toggle_word_diff<CR>' },
    { '<leader>gd', '<cmd>Gitsigns diffthis<CR>' },
  },
  opts = {
    signs = {
      change = { text = 'M' },
      delete = { text = 'D' },
      topdelete = { text = 'D' },
      changedelete = { text = 'D' },
    },
  },
  config = function()
    require('gitsigns').setup {
      current_line_blame = true,
    }
  end,
}
