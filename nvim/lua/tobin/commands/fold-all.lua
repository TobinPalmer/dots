local function fold_all()
  vim.opt.foldmethod = 'indent'
  vim.opt.foldclose = 'all'
  vim.opt.foldlevel = 1
end

vim.api.nvim_create_user_command('FoldAll', fold_all, {})
