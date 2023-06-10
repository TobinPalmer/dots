local dependencies = {
  'SmiteshP/nvim-navic',
}
if vim.g.opts.use_icons then
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  }
end

return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  dependencies = dependencies,
  opts = {
    -- configurations go here
  },
}
