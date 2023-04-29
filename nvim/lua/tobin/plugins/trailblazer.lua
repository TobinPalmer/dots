return {
  'LeonHeidelbach/trailblazer.nvim',
  event = 'BufReadPre',
  config = function()
    require('focus').setup()
  end,
}
