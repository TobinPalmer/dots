return {
  'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup {
      templates = { 'tobin.typescript' },
    }
  end,
}
