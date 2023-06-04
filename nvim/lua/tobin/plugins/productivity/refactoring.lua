return {
  'ThePrimeagen/refactoring.nvim',
  event = 'BufReadPost',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  config = function()
    vim.keymap.set(
      'v',
      '<leader>rr',
      ":lua require('refactoring').select_refactor()<CR>",
      { noremap = true, silent = true, expr = false }
    )
  end,
}
