return {
  'numToStr/FTerm.nvim',
  keys = {
    { '<leader>mt', '<CMD>lua require("FTerm").toggle()<CR>', desc = 'Toggle Term' },
  },
  config = function()
    require('FTerm').setup {
      border = 'double',
      dimensions = {
        height = 0.85,
        width = 0.85,
      },
    }
    vim.keymap.set('t', '<ESC>h', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
  end,
}
