return {
  {
    'folke/trouble.nvim',
    keys = {
      { '<leader>tt', '<CMD>TroubleToggle<cr>', desc = 'Toggle Diagnostics' },
      { '<leader>tw', '<CMD>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics' },
      { '<leader>td', '<CMD>TroubleToggle document_diagnostics<cr>', desc = 'Current Buffer Diagnostics' },
      { '<leader>tq', '<CMD>TroubleToggle quickfix<cr>', desc = 'Toggle quickfix menu' },
      { '<leader>dr', '<CMD>TroubleToggle lsp_references<cr>', desc = 'References' },
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
