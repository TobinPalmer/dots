return {
  'phaazon/hop.nvim',
  event = 'BufReadPost',
  branch = 'v2',
  config = function()
    require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
  end,
}
