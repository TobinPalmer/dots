_G.copy_all = function()
  vim.api.nvim_command 'norm ggVG"+y'
end

vim.api.nvim_command 'command! CopyAll lua copy_all()'
