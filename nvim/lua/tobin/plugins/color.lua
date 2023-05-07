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
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    -- event = 'BufReadPre',
    config = function()
      vim.cmd [[ colorscheme dracula ]]
    end,
  },
  {
    'marko-cerovac/material.nvim',
    priority = 1000,
    lazy = false,
    -- event = 'BufReadPre',
    config = function()
      require('material').setup {
        plugins = {
          'indent-blankline',
          'lspsaga',
          'nvim-cmp',
          'nvim-tree',
          'nvim-web-devicons',
          'telescope',
          'trouble',
          'which-key',
        },
      }
      vim.g.material_style = 'deep ocean'
      -- vim.g.material_style = 'palenight'
      vim.cmd 'colorscheme material'
    end,
  },
  {
    'folke/tokyonight.nvim',
    -- priority = 1000,
    -- lazy = false,
    event = 'BufReadPre',
    config = function()
      -- vim.cmd [[ colorscheme tokyonight-night ]]
    end,
  },
}
