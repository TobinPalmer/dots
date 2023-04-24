return {
  'beauwilliams/focus.nvim',
  event = 'BufReadPre',
  config = function()
    require('focus').setup()
  end,
}
