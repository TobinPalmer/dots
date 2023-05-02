return {
  'dbinagi/nomodoro',
  event = 'BufReadPre',
  config = function()
    require('nomodoro').setup {}
  end,
}
