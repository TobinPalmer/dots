local M = {}

M.format = function()
  local special = { 'js', 'ts' }

  local function is_special()
    local ext = vim.fn.expand [[%:e]]
    for _, v in ipairs(special) do
      if v == ext then
        return true
      end
    end
    return false
  end

  if is_special() then
    vim.cmd [[ silent! EslintFixAll ]]
  else
    vim.lsp.buf.format()
  end
end

return M
