return {
  'nvim-telescope/telescope-frecency.nvim',
  cmd = { 'Telescope find_files' },
  config = function()
    require('telescope').load_extension 'frecency'
  end,
  requires = { 'kkharji/sqlite.lua' },
}
