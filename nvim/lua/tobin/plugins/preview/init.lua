local plugins = {
  require 'tobin.plugins.preview.preview',
  require 'tobin.plugins.preview.vimtex',
}

if not vim.g.opts.minimal then
  local nonMinimalPlugins = {}

  table.insert(plugins, nonMinimalPlugins)
end

return plugins
