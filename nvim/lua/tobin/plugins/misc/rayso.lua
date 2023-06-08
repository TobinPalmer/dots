return {
  'TobinPalmer/rayso.nvim',
  keys = {
    'leader>rs',
  },
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
    vim.keymap.set('v', '<leader>rs', require('lib.create').create_snippet)
  end,
}
