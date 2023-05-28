local function remove_non_unique_lines()
  local current_line = vim.fn.line '.'

  local success, _ = pcall(function()
    vim.cmd [[%s/\v^(.*)(\n\1)+$/\1/]]
  end)

  if not success then
    vim.notify('No matching lines found.', vim.log.levels.WARN)
  end

  vim.fn.cursor { current_line, 0 }
end

vim.api.nvim_create_user_command('Uniq', remove_non_unique_lines, {})
