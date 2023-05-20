return {
  'debugloop/telescope-undo.nvim',
  cmd = { 'Telescope undo' },
  config = function()
    require('telescope').load_extension 'undo'
  end,
}
