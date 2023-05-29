return {
  'glepnir/lspsaga.nvim',
  event = 'LspAttach',
  config = function()
    require('lspsaga').setup {
      symbols_in_winbar = {
        enable = false,
        show_icons = false,
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
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
}
