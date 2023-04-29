return {
  {
    'AlexvZyl/nordic.nvim',
    -- lazy = false,
    -- priority = 1000,
    event = 'BufReadPre',
    config = function()
      -- require('nordic').load()
    end,
  },
  {
    'JoosepAlviste/palenightfall.nvim',
    -- lazy = false,
    -- priority = 1000,
    event = 'BufReadPre',
    config = function()
      -- require('palenightfall').setup {}
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    -- lazy = false,
    -- priority = 1000,
    event = 'BufReadPre',
    config = function()
      -- vim.cmd [[ colorscheme catppuccin ]]
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    -- event = 'BufReadPre',
    config = function()
      vim.cmd [[ colorscheme tokyonight-night ]]
    end,
  },
}
