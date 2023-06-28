return {
  'uga-rosa/ccc.nvim',
  event = 'BufReadPost',
  keys = {
    { '<leader>ca', '<CMD>CccPick<CR>' },
    { '<leader>cc', '<CMD>CccConvert<CR>' },
  },
  config = function()
    local ccc = require 'ccc'

    ccc.setup {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    }
  end,
}
