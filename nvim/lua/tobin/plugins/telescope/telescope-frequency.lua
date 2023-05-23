return {
  'nvim-telescope/telescope-frecency.nvim',
  cmd = { 'Telescope find_files' },
  config = function()
    require('telescope').load_extension 'frecency'
  end,
  dependencies = { 'kkharji/sqlite.lua' },
}
