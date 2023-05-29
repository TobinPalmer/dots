local plugins = {
  require 'tobin.plugins.lsp.treesitter',
  require 'tobin.plugins.lsp.cmp',
  require 'tobin.plugins.lsp.lsp',
  require 'tobin.plugins.lsp.copilot',
  require 'tobin.plugins.lsp.lspsaga',
  require 'tobin.plugins.lsp.null_ls',
  require 'tobin.plugins.lsp.mason-tools',
  require 'tobin.plugins.lsp.lsp-config',
  require 'tobin.plugins.lsp.inlay-hints',
}

if not vim.g.opts.minimal then
  local nonMinimalPlugins = {
    require 'tobin.plugins.lsp.inc-rename',
  }

  table.insert(plugins, nonMinimalPlugins)
end

return plugins
