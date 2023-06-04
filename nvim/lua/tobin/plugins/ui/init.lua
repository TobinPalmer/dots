local plugins = {
  require 'tobin.plugins.ui.alpha',
  require 'tobin.plugins.ui.color',
  require 'tobin.plugins.ui.bufferline',
  require 'tobin.plugins.ui.lualine',
}

if not vim.g.opts.minimal then
  local nonMinimalPlugins = {
    require 'tobin.plugins.ui.noice',
    require 'tobin.plugins.ui.notify',
  }
  if vim.bo.ft == 'tex' then
    nonMinimalPlugins = {}
  end

  table.insert(plugins, nonMinimalPlugins)
end

return plugins
