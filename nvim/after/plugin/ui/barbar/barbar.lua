require('barbar').setup {
  animation = true,
  icons = {
    -- inactive = { separator = { left = '', right = '' } },
    pinned = { button = '􀎦' },
    -- separator = { left = '', right = '' },
    buffer_index = true,
    highlight_alternate = true,
    filetype = { custom_colors = false, enabled = false },
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true },
      [vim.diagnostic.severity.WARN] = { enabled = true },
      [vim.diagnostic.severity.INFO] = { enabled = true },
    },
  },
}
