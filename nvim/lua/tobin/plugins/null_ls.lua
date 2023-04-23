local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

return {
  'jose-elias-alvarez/null-ls.nvim',
  event = 'LspAttach',
  config = function()
    local nls = require 'null-ls'

    nls.setup {
      sources = {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.prettier,
        nls.builtins.formatting.beautysh,
        nls.builtins.formatting.bibclean,
        nls.builtins.diagnostics.eslint,
        nls.builtins.diagnostics.gitlint,
        nls.builtins.code_actions.eslint_d,
        nls.builtins.code_actions.gitsigns,
        nls.builtins.completion.spell,
      },
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        end
      end,

      nls.register {
        name = 'more_actions',
        method = { require('null-ls').methods.CODE_ACTION },
        filetypes = { '_all' },
        generator = {
          fn = require('ts-node-action').available_actions,
        },
      },
    }

    --    nls.setup {
    --      debug = false,
    --      sources = {
    --        nls.builtins.formatting.stylua,
    --        nls.builtins.formatting.prettierd.with {
    --          disabled_filetypes = { 'markdown', 'yaml' },
    --        },
    --      },
    --    }
  end,
}
