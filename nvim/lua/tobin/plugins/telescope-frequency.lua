return {
  'nvim-telescope/telescope-frecency.nvim',
  event = 'UIEnter',
  config = function()
    require('telescope').load_extension 'frecency'
  end,
  requires = { 'kkharji/sqlite.lua' },
}
