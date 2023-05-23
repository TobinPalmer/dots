local x = 5
x = x + 1
return {
  'smjonas/inc-rename.nvim',
  event = 'LspAttach',
  config = function()
    require('inc_rename').setup()
  end,
}
