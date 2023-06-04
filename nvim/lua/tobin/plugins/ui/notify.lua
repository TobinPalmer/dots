return {
  'rcarriga/nvim-notify',
  event = 'BufReadPost',
  config = function()
    local notify = require 'notify'

    vim.notify = function(message, level, opts)
      return notify(message, level, opts) -- <-- Important to return the value from `nvim-notify`
    end
    require('notify').setup {
      background_colour = '#000000',
    }
  end,
}
