require('neodev').setup {}
require('mason').setup {}
require('mason-lspconfig').setup {}

require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}
