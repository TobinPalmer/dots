return {
  'ellisonleao/carbon-now.nvim',
  cmd = { 'CarbonNow' },
  config = function()
    vim.keymap.set('v', '<leader>cn', ':CarbonNow<CR>', { silent = true })
    require('carbon-now').setup {
      { open_cmd = 'google-chrome' },
    }
  end,
}
