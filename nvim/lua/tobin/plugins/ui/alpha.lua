return {
  'TobinPalmer/alpha-nvim',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl_shortcut = 'Macro'
      return b
    end

    local icons = require 'tobin.icons'

    dashboard.section.header.val = {
      [[                                                    ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      [[                                                    ]],
    }
    local api = vim.api
    local map = api.nvim_buf_set_keymap
    local current_bufnr = api.nvim_get_current_buf()

    if vim.g.opts.minimal then
      map(current_bufnr, 'n', 'q', '<CMD>qa!<CR>', { noremap = true, silent = true })
      map(current_bufnr, 'n', 'e', '<CMD>ene <BAR> startinsert<CR>', { noremap = true, silent = true })
      map(current_bufnr, 'n', 't', '<CMD>FzfLua live_grep<CR>', { noremap = true, silent = true })
      map(current_bufnr, 'n', 'r', '<CMD>FzfLua oldfiles<CR>', { noremap = true, silent = true })
      map(current_bufnr, 'n', 'u', '<CMD>Lazy update<CR>', { noremap = true, silent = true })
      map(
        current_bufnr,
        'n',
        'c',
        '<CMD>e ~/.config/nvim/init.lua<CR><CMD>cd %:p:h<CR>',
        { noremap = true, silent = true }
      )
      map(
        current_bufnr,
        'n',
        's',
        '<CMD>lua require("persistence").load({ last = true })<CR>',
        { noremap = true, silent = true }
      )
      dashboard.section.buttons.val = {}
    else
      if vim.g.opts.use_icons then
        dashboard.section.buttons.val = {
          button('e', icons.ui.NewFile .. ' New file', '<CMD>ene <BAR> startinsert<CR>'),
          button('f', icons.documents.File .. ' Find file', '<CMD>FzfLua files<CR>'),
          button('r', icons.documents.Files .. ' Recent Files', '<CMD>FzfLua oldfiles<CR>'),
          button('s', icons.ui.SignIn .. ' Last Session', '<CMD>lua require("persistence").load({ last = true })<CR>'),
          button('c', icons.ui.Gear .. ' Config', '<CMD>e ~/.config/nvim/init.lua<CR><CMD>cd %:p:h<CR>'),
          button('u', icons.ui.CloudDownload .. ' Update', '<CMD>Lazy update<CR>'),
          button('q', icons.ui.SignOut .. ' Quit', '<CMD>qa!<CR>'),
        }
      else
        dashboard.section.buttons.val = {
          button('e', ' New file', '<CMD>ene <BAR> startinsert<CR>'),
          button('f', ' Find file', '<CMD>FzfLua files<CR>'),
          button('r', ' Recent Files', '<CMD>FzfLua oldfiles<CR>'),
          button('s', ' Last Session', '<CMD>lua require("persistence").load({ last = true })<CR>'),
          button('c', ' Config', '<CMD>e ~/.config/nvim/init.lua<CR><CMD>cd %:p:h<CR>'),
          button('u', ' Update', '<CMD>Lazy update<CR>'),
          button('q', ' Quit', '<CMD>qa!<CR>'),
        }
      end
    end

    dashboard.section.header.opts.hl = 'Include'
    dashboard.section.buttons.opts.hl = 'Macro'
    dashboard.section.footer.opts.hl = 'Type'

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        if vim.g.opts.use_icons then
          dashboard.section.footer.val = icons.misc.Lightning
            .. 'Neovim loaded '
            .. stats.count
            .. ' plugins in '
            .. ms
            .. 'ms'
        else
          dashboard.section.footer.val = ' Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
        end
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    dashboard.section.header.opts.hl = 'Include'
    dashboard.section.buttons.opts.hl = 'Macro'
    dashboard.section.footer.opts.hl = 'Type'

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
