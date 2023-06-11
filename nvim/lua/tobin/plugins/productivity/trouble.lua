return {
  {
    'folke/trouble.nvim',
    keys = {
      { '<leader>tt', '<CMD>TroubleToggle document_diagnostics<CR>', desc = 'Toggle Diagnostics' },
      { '<leader>tw', '<CMD>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace Diagnostics' },
      { '<leader>td', '<CMD>TroubleToggle document_diagnostics<CR>', desc = 'Current Buffer Diagnostics' },
      { '<leader>tq', '<CMD>TroubleToggle quickfix<CR>', desc = 'Toggle quickfix menu' },
      { '<leader>dr', '<CMD>TroubleToggle lsp_references<CR>', desc = 'References' },
    },
    cmd = { 'TroubleToggle' },
    opts = {
      icons = vim.g.opts.use_icons,
    },
  },
  {
    'edr3x/lsp_lines.nvim',
    keys = {
      {
        '<leader>gl',
        function()
          require('lsp_lines').toggle()
        end,
        desc = 'Toggle lsp_lines',
      },
    },
    opts = {},
  },
}
