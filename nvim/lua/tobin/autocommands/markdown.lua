vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.md' },
  callback = function()
    vim.cmd [[set spell]]
  end,
})
