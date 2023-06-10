return {
  'mawkler/modicator.nvim',
  event = 'BufReadPost',
  init = function()
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
  config = function()
    require('modicator').setup {
      highlights = {
        defaults = {
          bold = true,
          italic = true,
        },
      },
    }
  end,
}
