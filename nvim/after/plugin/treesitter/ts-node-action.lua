require('ts-node-action').setup {
  {
    ['*'] = {
      'parameters' == require 'ts-node-action.actions.toggle_multiline'(),
    },
    ['lua'] = {
      'parameters' == require 'ts-node-action.actions.toggle_multiline'(),
    },
  },
}

-- TS Node Action
vim.keymap.set('n', '<leader>k', require('ts-node-action').node_action, { desc = 'Trigger Node Action' })
