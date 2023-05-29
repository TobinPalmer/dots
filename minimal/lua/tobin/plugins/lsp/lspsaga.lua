local dependencies = {}
if vim.g.opts.use_icons then
  dependencies = { 'nvim-tree/nvim-web-devicons' }
end
return {
  'glepnir/lspsaga.nvim',
  keys = {
    { '<leader>ga', '<CMD>Lspsaga code_action<CR>', desc = 'Lsp Code Action' },
    { '<leader>gd', '<CMD>Lspsaga goto_definition<CR>', desc = 'Goto Definition' },
    { '<leader>gf', '<CMD>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' },
    { '<leader>go', '<CMD>Lspsaga outline<CR>', desc = 'Document Outline' },
    { '<leader>gp', '<CMD>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' },
    { '<leader>gt', '<CMD>Lspsaga peek_type_definition<CR>', desc = 'Peek Type Definition' },
    { '<leader>sb', '<CMD>Lspsaga show_buf_diagnostics<CR>', desc = 'Show Buffer Diagnostics' },
    { '<leader>sw', '<CMD>Lspsaga show_workspace_diagnostics<CR>', desc = 'Show workspace Diagnostics' },
    { 'K', '<CMD>Lspsaga hover_doc<CR>', desc = 'Lsp Hover' },
    { '[e', '<CMD>Lspsaga diagnostic_jump_prev<CR>', desc = 'Jump Next Error' },
    { ']e', '<CMD>Lspsaga diagnostic_jump_next<CR>', desc = 'Jump Prev Error' },
  },
  cmd = { 'Lspsaga' },
  config = function()
    require('lspsaga').setup {
      symbol_in_winbar = {
        enable = vim.g.opts.minimal,
        separator = ' ',
        ignore_patterns = {},
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        respect_root = false,
        color_mode = true,
      },
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
      },
    }
  end,
  dependencies = dependencies,
}
