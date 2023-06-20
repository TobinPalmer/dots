return {
  'nvim-lualine/lualine.nvim',
  event = 'BufReadPre',
  opts = function()
    local concat = ' '
    if vim.g.opts.use_icons then
      concat = ''
    end
    local icons = require 'tobin.icons'
    require('lualine').setup {
      sections = {},
    }

    local component_separators, section_separators = { left = '', right = '' }, { left = '', right = '' }

    if vim.g.opts.lualine.style == 'line' then
      component_separators, section_separators = { left = '', right = '' }, { left = '', right = '' }
    end

    local lualine_c = {}
    if not vim.g.opts.minimal and not vim.g.neovide and vim.g.opts.noice then
      lualine_c = {
        {
          require('noice').api.statusline.mode.get,
          cond = require('noice').api.statusline.mode.has,
          color = { fg = '#ff9e64' },
        },
      }
    end

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

    local diff = {
      'diff',
      symbols = {
        added = icons.git.Add .. concat,
        modified = icons.git.Mod .. concat,
        removed = icons.git.Remove .. concat,
      },
    }

    return {
      options = {
        icons_enabled = vim.g.opts.use_icons,
        component_separators = component_separators,
        section_separators = section_separators,

        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = lualine_c,
        lualine_x = { diff },
        lualine_y = { lspStatus, 'filetype' },
        lualine_z = { 'progress' },
      },
    }
  end,
}
