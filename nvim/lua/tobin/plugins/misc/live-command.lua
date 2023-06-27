return {
  'smjonas/live-command.nvim',
  event = 'CmdlineEnter',
  config = function()
    require('live-command').setup {
      commands = {
        Norm = { cmd = 'norm' },
        G = { cmd = 'g' },
      },
    }
  end,
}
