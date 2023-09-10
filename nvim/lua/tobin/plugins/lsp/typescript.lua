return {
  {
    'pmizio/typescript-tools.nvim',
    -- ft = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
    config = function()
      require('typescript-tools').setup {
        settings = {
          tsserver_path = '/opt/homebrew/bin/tsserver',
        },
      }
    end,
  },
  {
    'dmmulroy/tsc.nvim',
    opts = {},
  },
}
