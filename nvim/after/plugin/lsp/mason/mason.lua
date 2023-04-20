local lspconfig = require 'lspconfig'
local masonlspconfig = require 'mason-lspconfig'
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_attach = function(client, bufnr) end

require('mason').setup()

masonlspconfig.setup {
  ensure_installed = {
    'rust_analyzer',
    'tsserver',
    'lua_ls',
  },
}

masonlspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = lsp_attach,
      capabilities = lsp_capabilities,
    }
  end,
}

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
