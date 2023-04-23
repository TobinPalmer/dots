return {
  'KadoBOT/nvim-spotify',
  dependencies = 'nvim-telescope/telescope.nvim',
  event = 'BufReadPre',
  config = function()
    local spotify = require 'nvim-spotify'

    spotify.setup {
      status = {
        update_interval = 10000, -- the interval (ms) to check for what's currently playing
        format = '%s %t by %a', -- spotify-tui --format argument
      },
    }
  end,
  build = 'make',
}
