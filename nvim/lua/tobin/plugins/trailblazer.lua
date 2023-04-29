return {
  'LeonHeidelbach/trailblazer.nvim',
  event = 'BufReadPre',
  config = function()
    require('trailblazer').setup {
      -- your custom config goes here
    }
  end,
}
