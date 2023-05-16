local winbar_config = nil
if vim.g.neovide then
  winbar_config = {
    enable = true,
    separator = ' ',
    ignore_patterns = {},
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
  }
end

return {
  'glepnir/lspsaga.nvim',
  event = 'LspAttach',
  config = function()
    require('lspsaga').setup {
      symbol_in_winbar = {
        winbar_config,
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
    {
      'nvim-treesitter/nvim-treesitter',
      event = 'LspAttach',
      opts = {
        ensure_installed = {
          'bash',
          'html',
          'javascript',
          'json',
          'lua',
          'markdown',
          'markdown_inline',
          'python',
          'query',
          'regex',
          'typescript',
          'vim',
          'yaml',
        },
      },
    },
  },
}
