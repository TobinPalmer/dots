return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      '<S-CR>',
      mode = { 'n', 'x', 'o' },
      function()
        -- default options: exact mode, multi window, all directions, with a backdrop
        require('flash').jump()
      end,
    },
    {
      '*',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump {
          pattern = vim.fn.expand '<cword>',
        }
      end,
    },
  },
}
