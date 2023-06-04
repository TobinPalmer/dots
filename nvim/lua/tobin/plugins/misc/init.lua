local plugins = {
  require 'tobin.plugins.misc.nvim-tree',
  require 'tobin.plugins.misc.comment',
  require 'tobin.plugins.misc.which-key',
  require 'tobin.plugins.misc.plenary',
  require 'tobin.plugins.misc.persistance',
  require 'tobin.plugins.misc.rayso',
  require 'tobin.plugins.misc.FTerm',
}

if not vim.g.opts.minimal then
  local nonMinimalPlugins = {
    require 'tobin.plugins.misc.useless',
    require 'tobin.plugins.misc.carbon',
  }

  table.insert(plugins, nonMinimalPlugins)
end

return plugins
