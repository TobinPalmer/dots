require('bigfile').config {
  filesize = 1,
  pattern = { '*' },
  features = {
    'indent_blankline',
    'illuminate',
    'lsp',
    'treesitter',
    'syntax',
    'matchparen',
    'vimopts',
    'filetype',
    'syntax',
  },
}
