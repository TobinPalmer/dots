return {
  'petertriho/nvim-scrollbar',
  version = false,
  event = 'BufReadPre',
  config = function()
    require('scrollbar').setup()
  end,
}
