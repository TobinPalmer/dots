return {
  'dmmulroy/tsc.nvim',
  cmd = { 'TSC' },
  ft = { 'typescript', 'typescriptreact' },
  config = function()
    require('tsc').setup()
  end,
}
