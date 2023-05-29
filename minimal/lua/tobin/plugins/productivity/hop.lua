return {
  'phaazon/hop.nvim',
  branch = 'v2',
  keys = {
    { '<S-CR>', '<CMD>HopWord<CR>', desc = 'Hop Word' },
    { '<leader>hh', '<CMD>HopWord<CR>', desc = 'Hop Word' },
    { '<leader>hp', '<CMD>HopPattern<CR>', desc = 'Hop Pattern' },
    { '<leader>ha', '<CMD>HopAnywhereCurrentLine<CR>', desc = 'Hop Word Anywhere In Current Line' },
    { '<leader>hs', '<CMD>HopChar2<CR>', desc = 'Hop Word (2 Characters)' },
  },
  config = function()
    local success, _ = pcall(require, 'hop')
    if not success then
      return
    end
    require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
  end,
}
