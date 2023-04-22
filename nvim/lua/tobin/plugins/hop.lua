return {
  'phaazon/hop.nvim',
  event = 'BufReadPre',
  branch = 'v2',
  config = function()
    require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
  end,
}
