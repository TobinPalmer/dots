return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },
  { 'nvim-lua/plenary.nvim' },
}
