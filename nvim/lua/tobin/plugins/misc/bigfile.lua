return {
  'LunarVim/bigfile.nvim',
  event = 'BufReadPre',
  config = function()
    require('bigfile').setup {
      filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
      pattern = { '*' }, -- autocmd pattern
      features = { -- features to disable
        'indent_blankline',
        'illuminate',
        'lsp',
        'treesitter',
        'syntax',
        'matchparen',
        'vimopts',
        'filetype',
      },
    }
  end,
}
