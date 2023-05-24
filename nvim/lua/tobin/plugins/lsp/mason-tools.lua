return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  config = function()
    require('mason-tool-installer').setup {
      ensure_installed = {
        'bash-language-server',
        'lua-language-server',
        'vim-language-server',
        'gopls',
        'stylua',
        'shellcheck',
        'editorconfig-checker',
        'gofumpt',
        'golines',
        'gomodifytags',
        'gotests',
        'impl',
        'json-to-struct',
        'luacheck',
        'misspell',
        'revive',
        'shellcheck',
        'shfmt',
        'staticcheck',
        'vint',
      },
      auto_update = false,
      run_on_start = true,
    }
  end,
}
