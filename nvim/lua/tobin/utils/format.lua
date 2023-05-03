local M = {}

M.format = function()
  local special = { 'js', 'ts' }

  local function is_special()
    local ext = vim.fn.expand '%:e'
    for _, v in ipairs(special) do
      if v == ext then
        return true
      end
    end
    return false
  end

  if is_special() then
    vim.cmd [[autocmd BufWritePre *.{ts,js} silent! EslintFixAll]]
  else
    vim.cmd [[autocmd BufWritePre * silent! lua vim.lsp.buf.format()]]
  end
end

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.lua' },
  callback = M.format,
})

return M
