return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  enabled = vim.g.opts.noice,
  config = function()
    require('noice').setup {
      lsp = {
        signature = { enabled = false },
        hover = { enabled = false },
        progress = {
          enabed = false,
          format = 'lsp_progress',
          format_done = 'lsp_progress_done',
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = 'mini',
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'notify',
            min_height = 15,
          },
          view = 'split',
        },
        {
          filter = {
            event = 'msg_show',
            kind = 'wmsg',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = '50%',
          },
          size = {
            width = 60,
            height = 'auto',
          },
        },
        popupmenu = {
          relative = 'editor',
          position = {
            row = 8,
            col = '50%',
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = 'rounded',
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
          },
        },
      },
      presets = {
        long_message_to_split = true,
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    -- {
    --   'TobinPalmer/nvim-lsp-notify',
    --   config = function()
    --     require('lsp-notify').setup {}
    --   end,
    -- },
  },
}
