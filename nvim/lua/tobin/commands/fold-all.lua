local function fold_all()
  vim.cmd [[
    set foldmethod=indent
    set foldlevel=1
    set foldclose=all
  ]]
end

vim.api.nvim_create_user_command('FoldAll', fold_all, {})
