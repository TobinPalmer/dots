local winblend = 0
if vim.g.neovide then
  winblend = 50
end
return {
  'folke/which-key.nvim',
  event = 'BufReadPre',
  config = function()
    -- disable hints for certain operators
    local presets = require 'which-key.plugins.presets'
    presets.operators['v'] = nil
    presets.operators['c'] = nil
    presets.operators['d'] = nil
    presets.operators['y'] = nil

    local wk = require 'which-key'

    wk.setup {
      window = {
        border = 'none', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = winblend, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        zindex = 1000, -- positive value to position WhichKey above other floating windows.
      },
    }
    wk.register({
      b = { name = 'Buffer' },
      f = { name = 'Telescope' },
      g = { name = 'LSP Actions' },
      t = { name = 'Trouble' },
    }, { prefix = '<leader>' })
  end,
}
