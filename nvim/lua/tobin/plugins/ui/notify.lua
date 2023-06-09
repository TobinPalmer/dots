return {
  'rcarriga/nvim-notify',
  event = 'BufReadPost',
  keys = {
    { '<leader>nd', '<CMD>Noice dismiss<CR>' },
  },
  config = function()
    local notify = require 'notify'

    vim.notify = function(message, level, opts)
      return notify(message, level, opts) -- <-- Important to return the value from `nvim-notify`
    end

    require('notify').setup {
      -- background_colour = '#000000',
      fps = 144,
      minimum_width = 50,
      max_width = 100,
      render = 'default',
      stages = 'fade_in_slide_out',
      timeout = 0,
      top_down = true,
    }
  end,
}
