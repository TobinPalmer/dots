local dependencies = {}
if vim.g.opts.use_icons then
  dependencies = { 'nvim-tree/nvim-web-devicons' }
end
return {
  'glepnir/lspsaga.nvim',
  keys = {
    { 'K', '<CMD>Lspsaga hover_doc<CR>', desc = 'Lsp Hover' },
    { 'gd', '<CMD>Lspsaga goto_definition<CR>', desc = 'Goto Definition' },
    { '<leader>go', '<CMD>Lspsaga outline<CR>', desc = 'Document Outline' },
    { '<leader>gf', '<CMD>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' },
    { '<leader>gp', '<CMD>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' },
    { '<leader>ga', '<CMD>Lspsaga code_action<CR>', desc = 'Lsp Code Action', mode = { 'n', 'x' } },
    { '[e', '<CMD>Lspsaga diagnostic_jump_prev<CR>', desc = 'Jump Next Error' },
    { ']e', '<CMD>Lspsaga diagnostic_jump_next<CR>', desc = 'Jump Prev Error' },
    { '<leader>gd', '<CMD>Lspsaga goto_definition<CR>', desc = 'Goto Definition' },
    { '<leader>gt', '<CMD>Lspsaga peek_type_definition<CR>', desc = 'Peek Type Definition' },
    { '<leader>sb', '<CMD>Lspsaga show_buf_diagnostics<CR>', desc = 'Show Buffer Diagnostics' },
    { '<leader>sw', '<CMD>Lspsaga show_workspace_diagnostics<CR>', desc = 'Show workspace Diagnostics' },
  },
  cmd = { 'Lspsaga' },
  config = function()
    require('lspsaga').setup {
      symbol_in_winbar = {
        enable = not vim.g.opts.minimal,
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
