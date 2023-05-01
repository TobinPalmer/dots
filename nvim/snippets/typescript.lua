require('luasnip.loaders.from_lua').lazy_load()
local env = SNIP_ENV

return {
  env.s('cl', {
    env.t 'console.log(',
    env.i(1),
    env.t ')'
  }),
}
