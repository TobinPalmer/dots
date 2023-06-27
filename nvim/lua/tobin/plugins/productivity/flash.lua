return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {},
  keys = {
    {
      '<S-CR>',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
    },
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        -- default options: exact mode, multi window, all directions, with a backdrop
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'o', 'x' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
  },
}
