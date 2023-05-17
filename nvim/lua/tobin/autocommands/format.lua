local format = require 'tobin.utils.format'
-- vim.cmd [[autocmd bufreadpost * lua format()]]
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    format.format()
  end,
})
