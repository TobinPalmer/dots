local function set_cwd()
  vim.cmd [[cd %:p:h]]
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = set_cwd })
