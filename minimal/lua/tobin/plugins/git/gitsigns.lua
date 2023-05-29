return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPost',
  keys = {
    { 'gn', '<CMD>Gitsigns next_hunk<CR>' },
    { 'gN', '<CMD>Gitsigns prev_hunk<CR>' },
    { '<leader>gb', '<CMD>Gitsigns blame_line<CR>' },
    { '<leader>gl', '<CMD>Gitsigns toggle_current_line_blame<CR>' },
    { '<leader>gw', '<CMD>Gitsigns diffthis<CR>' },
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
