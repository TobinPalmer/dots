return {
  'barrett-ruth/live-server.nvim',
  event = 'BufReadPre',
  build = 'yarn global add live-server',
  config = true,
}
