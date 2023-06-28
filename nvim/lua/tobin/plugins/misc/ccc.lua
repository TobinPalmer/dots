return {
  'uga-rosa/ccc.nvim',
  event = 'BufReadPost',
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
