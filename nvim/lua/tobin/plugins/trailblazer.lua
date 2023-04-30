return {
  'LeonHeidelbach/trailblazer.nvim',
  event = 'BufReadPre',
  config = function()
    require('trailblazer').setup {}
  end,
}
