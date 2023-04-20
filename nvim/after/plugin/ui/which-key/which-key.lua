local wk = require 'which-key'

wk.setup {}
wk.register({
  f = { name = 'file' },
  b = { name = 'buffer' },
  t = { name = 'Trouble' },
  m = { name = 'misc' },
  p = { name = 'file explorer' },
}, { prefix = '<leader>' })
