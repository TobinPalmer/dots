local function remove_non_unique_lines()
  -- Get the current line number
  local current_line = vim.fn.line '.'

  -- Execute the Vim command
  vim.cmd [[%s/\v^(.*)(\n\1)+$/\1/]]

  -- Move the cursor to the original line
  vim.fn.cursor { current_line, 0 }
end

vim.api.nvim_create_user_command('Uniq', remove_non_unique_lines, {})
