return {
  'jcdickinson/wpm.nvim',
  event = 'BufReadPre',
  config = function()
    require('wpm').setup {}
  end,
}
