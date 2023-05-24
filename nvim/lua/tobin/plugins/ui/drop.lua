return {
  'folke/drop.nvim',
  event = 'VimEnter',
  config = function()
    require('drop').setup {
      theme = 'summer',
      max = 50,
      interval = 150,
      screensaver = 3 * 1000 * 60,
      filetypes = {}, -- will enable/disable automatically for the following filetypes
    }
  end,
}
