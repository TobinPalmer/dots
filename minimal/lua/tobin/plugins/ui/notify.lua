return {
  'rcarriga/nvim-notify',
  event = 'BufReadPost',
  config = function()
    vim.notify = require 'notify'
    require('notify').setup {
      background_colour = '#000000',
    }
  end,
}
