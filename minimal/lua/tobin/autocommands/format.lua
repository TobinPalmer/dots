local format = require 'tobin.utils.format'

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    format.format()
  end,
})
