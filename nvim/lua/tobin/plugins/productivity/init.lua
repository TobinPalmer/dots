local plugins = {
  require 'tobin.plugins.productivity.fzf',
  require 'tobin.plugins.productivity.sub',
  require 'tobin.plugins.productivity.ufo',
  require 'tobin.plugins.productivity.flash',
  require 'tobin.plugins.productivity.marks',
  require 'tobin.plugins.productivity.neogen',
  require 'tobin.plugins.productivity.matchup',
  require 'tobin.plugins.productivity.mini-ai',
  require 'tobin.plugins.productivity.trouble',
  require 'tobin.plugins.productivity.windows',
  require 'tobin.plugins.productivity.surround',
  require 'tobin.plugins.productivity.autopairs',
  require 'tobin.plugins.productivity.templates',
  require 'tobin.plugins.productivity.web-tools',
  require 'tobin.plugins.productivity.refactoring',
  require 'tobin.plugins.productivity.template-string',
}

if not vim.g.opts.minimal then
  local nonMinimalPlugins = {}

  table.insert(plugins, nonMinimalPlugins)
end

return plugins
