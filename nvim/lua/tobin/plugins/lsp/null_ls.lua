local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

return {
  'jose-elias-alvarez/null-ls.nvim',
  event = 'LspAttach',
  config = function()
    local null_ls = require 'null-ls'

    local sources = {
      null_ls.builtins.completion.spell,
      null_ls.builtins.diagnostics.vint,
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.diagnostics.gitlint,
      null_ls.builtins.formatting.beautysh,
      null_ls.builtins.formatting.bibclean,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.diagnostics.write_good,
      null_ls.builtins.diagnostics.mdl,
      -- null_ls.builtins.formatting.markdownlint,
      -- null_ls.builtins.diagnostics.proselint,
      null_ls.builtins.code_actions.refactoring,
      -- null_ls.builtins.diagnostics.codespell,
      null_ls.builtins.formatting.codespell,
      null_ls.builtins.code_actions.proselint,
      -- null_ls.builtins.diagnostics.vale,
      null_ls.builtins.diagnostics.vale,
      null_ls.builtins.formatting.black.with {
        extra_args = { '--line-length=120' },
      },
    }

    local eslintSources = {
      -- null_ls.builtins.diagnostics.eslint,
      -- null_ls.builtins.code_actions.eslint_d,
    }

    if
      vim.fn.filereadable '.eslintrc' == 1
      or vim.fn.filereadable '.eslintrc.json' == 1
      or vim.fn.filereadable '.eslintrc.js' == 1
    then
      table.insert(sources, eslintSources)
    end

    null_ls.setup {
      sources = sources,

      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        end
      end,
    }
  end,
}
