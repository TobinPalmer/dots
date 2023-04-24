return {
  'goolord/alpha-nvim',
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
      [[                                                                       ]],
      [[  ██████   █████                   █████   █████  ███                  ]],
      [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
      [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
      [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
      [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
      [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
      [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
      [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
      [[                                                                       ]],
    }
    dashboard.section.buttons.val = {
      button('f', icons.documents.Files .. ' Find file', '<CMD>Telescope find_files<CR>'),
      button('e', icons.ui.NewFile .. ' New file', '<CMD>ene <BAR> startinsert<CR>'),
      button('r', icons.ui.History .. ' Recent files', '<CMD>Telescope oldfiles<CR>'),
      button('t', icons.ui.List .. ' Find text', '<CMD>Telescope live_grep<CR>'),
      button('s', icons.ui.SignIn .. ' Last Session', '<CMD>lua require("persistence").load({ last = true })<CR>'),
      button('c', icons.ui.Gear .. ' Config', '<CMD>e ~/.config/nvim/init.lua<CR><CMD>cd %:p:h<CR>'),
      button('u', icons.ui.CloudDownload .. ' Update', '<CMD>Lazy update<CR>'),
      button('q', icons.ui.SignOut .. ' Quit', '<CMD>qa<CR>'),
    }

    dashboard.section.header.opts.hl = 'Include'
    dashboard.section.buttons.opts.hl = 'Macro'
    dashboard.section.footer.opts.hl = 'Type'

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
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
