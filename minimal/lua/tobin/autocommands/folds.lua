local cwd = vim.fn.getcwd()

vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*.*',
  command = 'mkview',
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    vim.cmd [[ silent! loadview ]]
    vim.fn.execute('cd ' .. cwd)
  end,
})
