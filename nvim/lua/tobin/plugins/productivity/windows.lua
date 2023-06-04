local dependencies = {
  'anuvyklack/middleclass',
}
if not vim.g.opts.minimal then
  dependencies = {
    'anuvyklack/middleclass',
    'anuvyklack/animation.nvim',
  }
end

return {
  'anuvyklack/windows.nvim',
  dependencies = dependencies,
  keys = {
    { '|', '<CMD>vsplit<CR>', desc = 'Splits Left' },
    { '-', '<CMD>split<CR>', desc = 'Splits Down' },
  },
  event = 'BufReadPost',
  config = function()
    if not vim.g.minimal then
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
    end
    require('windows').setup()
  end,
}
