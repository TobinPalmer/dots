require('possession').setup {
  session_dir = vim.fn.stdpath 'data' .. '/sessions',
  plugins = {
    nvim_tree = true,
    tabby = true,
    delete_hidden_buffers = false,
    dap = true,
  },
}
