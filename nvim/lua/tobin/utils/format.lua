local M = {}
local autocommand_assigned = {}

M.special = { 'js', 'ts' }
M.special_client = { 'tsserver', 'eslint', 'texlab' }

M.format = function()
  local function is_special()
    local ext = vim.fn.expand [[%:e]]
    for _, v in ipairs(M.special) do
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

--- @param client lsp.Client
M.start_auto_format = function(client)
  if M.special_client[client.name] then
    return
  end

  if not autocommand_assigned[client.name] then
    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function()
        local ft = vim.bo.filetype
        local valid_filetypes = { 'js', 'ts', 'lua', 'py', 'sh' }

        if not vim.tbl_contains(valid_filetypes, ft) then
          return
        end
        if client.server_capabilities.documentFormattingProvider == false then
          M.format()
        end
      end,
    })
  end
  autocommand_assigned[client.name] = true
end

return M
