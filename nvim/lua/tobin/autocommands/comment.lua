vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.cmd [[ setlocal formatoptions-=cro ]]
    vim.cmd [[ setlocal comments-=:#]]
  end,
})
