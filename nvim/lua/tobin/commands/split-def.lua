local function open_split_with_definition()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  vim.cmd 'vsplit'
  vim.lsp.buf.definition()
  vim.api.nvim_win_set_cursor(0, { current_line, 0 })
end

vim.api.nvim_create_user_command('SplitDef', open_split_with_definition, {})

vim.keymap.set('n', '<leader>gd|', '<CMD>SplitDef<CR>', { noremap = true, silent = true })
