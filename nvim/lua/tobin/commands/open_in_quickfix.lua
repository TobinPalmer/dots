local function open_in_quickfix()
  local current_file = vim.fn.expand '%'

  vim.cmd [[vimgrep "\%^" **/*.*]]

  vim.cmd [[TroubleToggle quickfix]]

  vim.cmd('edit ' .. current_file)
end

vim.api.nvim_create_user_command('Quickfix', open_in_quickfix, {})
