return {
  -- UFO folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require 'statuscol.builtin'
          require('statuscol').setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
              { text = { '%s' }, click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          }
        end,
      },
    },
    event = 'BufReadPost',
    opts = {
      provider_selector = function()
        --        local success, _ = pcall(require, 'nvim-treesitter')
        -- if success then
        --   print 'pro'
        return { 'treesitter', 'indent' }
        -- else
        --   print 'noob'
        --   return { 'indent' }
        -- end
      end,
    },

    init = function()
      vim.keymap.set('n', 'zR', function()
        require('ufo').openAllFolds()
      end)
      vim.keymap.set('n', 'zM', function()
        require('ufo').closeAllFolds()
      end)
    end,
  },
}
