return {
  'numToStr/Comment.nvim',
  event = 'InsertEnter',
  config = function()
    require('Comment').setup()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    map('n', '<C-\\>', ":lua require('Comment.api').toggle.linewise.current()<CR>", opts)
    map('v', '<C-\\>', ":lua require('Comment.api').toggle.linewise.selected()<CR>", opts)
  end,
}
