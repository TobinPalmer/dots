return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  config = function()
    require('telescope').load_extension 'refactoring'
    vim.api.nvim_set_keymap(
      'v',
      '<leader>rr',
      "<Esc><CMD>lua require('telescope').extensions.refactoring.refactors()<CR>",
      { noremap = true }
    )
  end,
}
