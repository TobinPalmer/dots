local function no_highlight()
  vim.cmd [[noh]]
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'BufFilePost' }, { callback = no_highlight })
