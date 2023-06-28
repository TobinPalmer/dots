return {
  'folke/todo-comments.nvim',
  event = 'BufReadPost',
  keys = {
    { '<leader>tg', '<CMD>TodoTrouble<CR>', desc = 'Trouble Todo' },
  },
  config = function()
    require('todo-comments').setup()
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
}
