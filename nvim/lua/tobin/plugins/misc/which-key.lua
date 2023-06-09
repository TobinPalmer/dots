local winblend = 0
if vim.g.neovide then
  winblend = 50
end

return {
  'folke/which-key.nvim',
  event = 'BufReadPre',
  config = function()
    -- disable hints for certain operators
    local icons = require('tobin.icons').wk
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
    if vim.g.opts.use_icons then
      wk.register({
        b = { name = icons.Buffer .. 'Buffer' },
        f = { name = icons.FzfLua .. 'FzfLua' },
        g = { name = icons.Lsp .. 'LSP Actions' },
        t = { name = icons.Trouble .. 'Trouble' },
        p = { name = icons.Nvim_Tree .. 'Nvim-Tree' },
      }, { prefix = '<leader>' })
    else
    end
  end,
}
