require('luasnip.loaders.from_lua').lazy_load()
local env = SNIP_ENV

return {
  env.s('var', {
    env.t 'local ',
    env.i(1),
    env.t ' = ',
    env.i(2),
  }),
}
