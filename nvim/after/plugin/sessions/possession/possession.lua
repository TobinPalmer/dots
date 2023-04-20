-- require('possession').setup {
--   session_dir = vim.fn.stdpath 'data' .. '/sessions',
--   plugins = {
--     nvim_tree = true,
--     tabby = true,
--     delete_hidden_buffers = false,
--     dap = true,
--   },
-- }

require('persistence').setup {
  options = { --[[<other options>,]]
    'globals',
  },
  pre_save = function()
    vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
  end,
}
