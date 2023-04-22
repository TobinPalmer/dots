--return {
--  {
--    'nvim-lualine/lualine.nvim',
--    event = 'BufReadPre',
--    options = {
--      icons_enabled = true,
--      theme = 'tokyonight',
--      component_separators = { left = '', right = '' },
--      section_separators = { left = '', right = '' },
--      disabled_filetypes = {
--        statusline = {},
--        winbar = {},
--      },
--      ignore_focus = {},
--      always_divide_middle = true,
--      globalstatus = false,
--      refresh = {
--        statusline = 1000,
--        tabline = 1000,
--        winbar = 1000,
--      },
--    },
--    sections = {
--      lualine_a = { 'mode' },
--      lualine_b = { 'diff', 'diagnostics' },
--      lualine_c = { 'filename' },
--      lualine_x = {},
--      lualine_y = {},
--      lualine_z = { 'filetype', 'progress' },
--    },
--    inactive_sections = {
--      lualine_a = {},
--      lualine_b = {},
--      lualine_c = { 'filename' },
--      lualine_x = { 'location' },
--      lualine_y = {},
--      lualine_z = {},
--    },
--    tabline = {},
--    winbar = {},
--    inactive_winbar = {},
--    extensions = {},
--  },
--}
--
return {
  'nvim-lualine/lualine.nvim',
  event = 'BufReadPre',
  opts = function()
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
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'dashboard', 'lazy' },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {},
        lualine_x = { diff, diagnostic },
        lualine_y = { lspStatus, 'filetype' },
        lualine_z = { 'progress' },
      },
    }
  end,
}
