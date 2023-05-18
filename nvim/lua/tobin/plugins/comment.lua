return {
  'numToStr/Comment.nvim',
  keys = {
    { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
    { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
  },

  config = function()
    require('Comment').setup()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    map('n', '<C-\\>', ":lua require('Comment.api').toggle.linewise.current()<CR>", opts)
    map('v', '<C-\\>', ":lua require('Comment.api').toggle.linewise.selected()<CR>", opts)
  end,
}
