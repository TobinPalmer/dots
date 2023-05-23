return {
  'rcarriga/nvim-notify',
  event = 'BufReadPost',
  config = function()
    vim.notify = require 'notify'
  end,
}
