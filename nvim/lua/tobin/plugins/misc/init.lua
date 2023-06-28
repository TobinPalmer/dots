local plugins = {
  require 'tobin.plugins.misc.util',
  require 'tobin.plugins.misc.ccc',
  require 'tobin.plugins.misc.FTerm',
  require 'tobin.plugins.misc.rayso',
  require 'tobin.plugins.misc.rayso',
  require 'tobin.plugins.misc.bigfile',
  require 'tobin.plugins.misc.comment',
  require 'tobin.plugins.misc.pastify',
  require 'tobin.plugins.misc.bettergx',
  require 'tobin.plugins.misc.computer',
  require 'tobin.plugins.misc.overseer',
  require 'tobin.plugins.misc.wakatime',
  require 'tobin.plugins.misc.nvim-tree',
  require 'tobin.plugins.misc.which-key',
  require 'tobin.plugins.misc.persistence',
  require 'tobin.plugins.misc.todo-comments',
  require 'tobin.plugins.misc.live-command',
}

if not vim.g.opts.minimal then
  local nonMinimalPlugins = {
    require 'tobin.plugins.misc.useless',
  }

  table.insert(plugins, nonMinimalPlugins)
end

return plugins
