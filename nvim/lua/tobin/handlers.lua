local M = {}
local icons = require 'tobin.icons'

M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
    { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
    { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
    { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
    { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
      texthl = sign.name,
      text = sign.text,
      numhl = '',
    })
  end

  vim.diagnostic.config {
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  --   border = 'rounded',
  -- })

  -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  --   border = 'rounded',
  -- })

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = {
      spacing = 5,
      severity_limit = 'Hint',
    },
    update_in_insert = true,
  })

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
  vim.keymap.set('n', 'dn', vim.diagnostic.goto_next)
  vim.keymap.set('n', 'dN', vim.diagnostic.goto_prev)

  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank {
        higroup = 'IncSearch', -- see `:highlight` for more options
        timeout = 200,
      }
    end,
  })
end

local opts = { noremap = true, silent = true }

local signature_cfg = {
  bind = true,
  hint_enable = false,
  floating_window = true,
  floating_window_above_cur_line = true,
  check_completion_visible = true,
  toggle_key = '<M-t>',
  select_signature_key = '<M-s>',
  handler_opts = {
    border = 'rounded',
  },
}

local semantic_token_support = {
  'clangd',
  'rust-analyzer',
  'lua_ls',
  'pyright',
  'tsserver',
}

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

M.on_attach = function(client, bufnr)
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.name == 'lua_ls' then
    client.server_capabilities.documentFormattingProvider = false
  end

  for _, support_lang in pairs(semantic_token_support) do
    if not client.name == support_lang then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gg=G', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  vim.api.nvim_buf_create_user_command(bufnr, 'Fmt', function(_)
    vim.lsp.buf.format()
  end, {})

  require('illuminate').on_attach(client)

  require('lsp_signature').on_attach(signature_cfg, bufnr)
  require('nvim-navbuddy').attach(client, bufnr)
end

return M
