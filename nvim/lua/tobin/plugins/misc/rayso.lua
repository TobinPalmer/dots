return {
  'TobinPalmer/rayso.nvim',
  cmd = { 'Rayso' },
  config = function()
    require('rayso').setup {
      open_cmd = 'chromium',
      options = {
        logging_path = '/Users/tobin/Documents/Rayso/', -- Notices the trailing slash
        logging_file = 'rayso',
        logging_enabled = true,
        theme = 'midnight',
      },
    }
  end,
}
