local special = { 'js', 'ts' }
-- Check if current buffer's file extension is in special
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
  vim.cmd [[autocmd BufWritePost *.{ts,js} silent! EslintFixAll]]
else
  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
end
