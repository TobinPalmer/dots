return {
  'ThePrimeagen/refactoring.nvim',
  event = 'BufReadPost',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  config = function()
    vim.api.nvim_set_keymap(
      'v',
      '<leader>rr',
      "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
      { noremap = true }
    )
  end,
}
