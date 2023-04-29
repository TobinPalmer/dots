return {
  'nvim-lualine/lualine.nvim',
  event = 'BufReadPre',
  opts = function()
    local wpm = require 'wpm'
    local status = require('nvim-spotify').status

    status:start()

    require('lualine').setup {
      sections = {},
    }

    local lspStatus = {
      function()
        local msg = 'No LSP detected'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = '',
      color = { fg = '#d3d3d3' },
    }

    local diagnostic = {
      'diagnostics',
      symbols = {
        error = ' ',
        warn = ' ',
        info = ' ',
        hint = ' ',
      },
      icon = '|',
    }

    local diff = {
      'diff',
      symbols = {
        added = ' ',
        modified = ' ',
        removed = ' ',
      },
    }

    return {
      options = {
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'dashboard', 'lazy' },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { wpm.wpm, wpm.historic_graph },
        lualine_x = { status.listen, diff },
        lualine_y = { lspStatus, 'filetype' },
        lualine_z = { 'progress' },
      },
    }
  end,
}