require('illuminate').configure {
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  delay = 100,
  filetype_overrides = {},
  filetypes_denylist = {
    'dirvish',
    'fugitive',
  },
  under_cursor = true,
  large_file_cutoff = nil,
  large_file_overrides = nil,
  min_count_to_highlight = 1,
}

vim.cmd 'hi IlluminatedWordWrite guibg=#313047 gui=NONE'
vim.cmd 'hi IlluminatedWordRead guibg=#313047 gui=NONE'
vim.cmd 'hi IlluminatedWordText guibg=#313047 gui=NONE'
