local M = {}
local autocommand_assigned = {}

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

M.start_auto_format = function(client)
  if not autocommand_assigned[client.name] then
    print('starting autoforat for', client.name)
    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function()
        if
          client.server_capabilities.documentFormattingProvider == nil
          or client.server_capabilities.documentFormattingProvider == true
        then
          vim.cmd [[ lua vim.lsp.buf.format() ]]
        else
          require('tobin.utils.format').format()
        end
      end,
    })
  end
  autocommand_assigned[client.name] = true
end

return M
