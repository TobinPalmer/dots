local icons = require 'tobin.icons'
return {
  {
    'folke/neodev.nvim',
    lazy = false,
    priority = 1000,
    event = 'UiEnter',
  },
  {
    {
      'ray-x/lsp_signature.nvim',
      event = 'BufReadPre',
      config = function()
        require('lsp_signature').setup()
      end,
    },
    {
      'williamboman/mason.nvim',
      event = 'BufReadPre',
      opts = {
        ensure_installed = {
          'prettierd',
          'stylua',
        },
      },
    },
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'ray-x/lsp_signature.nvim',
        'RRethy/vim-illuminate',
      },
      event = 'BufReadPre',
      config = function()
        require('neodev').setup {}
        local lspconfig = require 'lspconfig'
        local root_pattern = require('lspconfig.util').root_pattern
        local on_attach = require('tobin.handlers').on_attach
        local capabilities = require('tobin.handlers').capabilities

        local servers = {
          'prismals',
          'dockerls',
          'jsonls',
          'pyright',
          'cssls',
          'bashls',
        }

        for _, lsp in pairs(servers) do
          lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end

        lspconfig['lua_ls'].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { globals = { 'vim' } },
              hint = { enable = true },
            },
          },
        }

        lspconfig['tsserver'].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        }

        lspconfig['rust_analyzer'].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' }, --TODO: `rustup component add rust-analyzer` to install LSP
          settings = {
            ['rust-analyzer'] = {
              procMacro = { enable = true },
              cargo = { allFeatures = true },
              checkOnSave = true,
              check = {
                command = 'clippy', --TODO: `rustup component add clippy` to install clippy
                extraArgs = { '--no-deps' },
              },
            },
          },
        }

        lspconfig['eslint'].setup {
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
        }

        lspconfig['gopls'].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        }

        lspconfig['yamlls'].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        }

        local cap = capabilities
        cap.offsetEncoding = 'utf-8'

        lspconfig['clangd'].setup {
          on_attach = on_attach,
          capabilities = cap,
        }

        lspconfig['tailwindcss'].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = root_pattern('tailwind.config.js', 'postcss.config.js'),
        }

        require('tobin.handlers').setup()
      end,
    },

    -- code formatters
    {
      'jose-elias-alvarez/null-ls.nvim',
      event = 'LspAttach',
      config = function()
        local nls = require 'null-ls'

        nls.setup {
          debug = false,
          sources = {
            nls.builtins.formatting.stylua,
            nls.builtins.formatting.prettierd.with {
              disabled_filetypes = { 'markdown', 'yaml' },
            },
          },
        }
      end,
    },
    -- code navigation
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      -- Call the setup function to change the default behavior
      require('aerial').setup {
        backends = { 'treesitter', 'lsp', 'markdown', 'man' },

        layout = {
          width = 0.5,
          win_opts = {},
          default_direction = 'prefer_right',
          placement = 'window',
          preserve_equality = false,
        },

        -- Determines how the aerial window decides which buffer to display symbols for
        --   window - aerial window will display symbols for the buffer in the window from which it was opened
        --   global - aerial window will display symbols for the current window
        attach_mode = 'window',

        -- List of enum values that configure when to auto-close the aerial window
        --   unfocus       - close aerial when you leave the original source window
        --   switch_buffer - close aerial when you change buffers in the source window
        --   unsupported   - close aerial when attaching to a buffer that has no symbol source
        close_automatic_events = {},

        -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("aerial.actions").<name>
        -- Set to `false` to remove a keymap
        keymaps = {
          ['?'] = 'actions.show_help',
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.jump',
          ['<2-LeftMouse>'] = 'actions.jump',
          ['<C-v>'] = 'actions.jump_vsplit',
          ['<C-s>'] = 'actions.jump_split',
          ['p'] = 'actions.scroll',
          ['<C-j>'] = 'actions.down_and_scroll',
          ['<C-k>'] = 'actions.up_and_scroll',
          ['{'] = 'actions.prev',
          ['}'] = 'actions.next',
          ['[['] = 'actions.prev_up',
          [']]'] = 'actions.next_up',
          ['q'] = 'actions.close',
          ['o'] = 'actions.tree_toggle',
          ['za'] = 'actions.tree_toggle',
          ['O'] = 'actions.tree_toggle_recursive',
          ['zA'] = 'actions.tree_toggle_recursive',
          ['l'] = 'actions.tree_open',
          ['zo'] = 'actions.tree_open',
          ['L'] = 'actions.tree_open_recursive',
          ['zO'] = 'actions.tree_open_recursive',
          ['h'] = 'actions.tree_close',
          ['zc'] = 'actions.tree_close',
          ['H'] = 'actions.tree_close_recursive',
          ['zC'] = 'actions.tree_close_recursive',
          ['zr'] = 'actions.tree_increase_fold_level',
          ['zR'] = 'actions.tree_open_all',
          ['zm'] = 'actions.tree_decrease_fold_level',
          ['zM'] = 'actions.tree_close_all',
          ['zx'] = 'actions.tree_sync_folds',
          ['zX'] = 'actions.tree_sync_folds',
        },

        -- When true, don't load aerial until a command or function is called
        -- Defaults to true, unless `on_attach` is provided, then it defaults to false
        lazy_load = true,

        -- Disable aerial on files with this many lines
        disable_max_lines = 10000,

        -- Disable aerial on files this size or larger (in bytes)
        disable_max_size = 2000000, -- Default 2MB

        -- A list of all symbols to display. Set to false to display all symbols.
        -- This can be a filetype map (see :help aerial-filetype-map)
        -- To see all available values, see :help SymbolKind
        filter_kind = {
          'Class',
          'Constructor',
          'Enum',
          'Function',
          'Interface',
          'Module',
          'Method',
          'Struct',
        },

        -- Determines line highlighting mode when multiple splits are visible.
        -- split_width   Each open window will have its cursor location marked in the
        --               aerial buffer. Each line will only be partially highlighted
        --               to indicate which window is at that location.
        -- full_width    Each open window will have its cursor location marked as a
        --               full-width highlight in the aerial buffer.
        -- last          Only the most-recently focused window will have its location
        --               marked in the aerial buffer.
        -- none          Do not show the cursor locations in the aerial window.
        highlight_mode = 'split_width',

        -- Highlight the closest symbol if the cursor is not exactly on one.
        highlight_closest = true,

        -- Highlight the symbol in the source buffer when cursor is in the aerial win
        highlight_on_hover = false,

        -- When jumping to a symbol, highlight the line for this many ms.
        -- Set to false to disable
        highlight_on_jump = 300,

        -- Jump to symbol in source window when the cursor moves
        autojump = false,

        -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
        -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
        -- default collapsed icon. The default icon set is determined by the
        -- "nerd_font" option below.
        -- If you have lspkind-nvim installed, it will be the default icon set.
        -- This can be a filetype map (see :help aerial-filetype-map)
        icons = {},
        manage_folds = false,

        -- When you fold code with za, zo, or zc, update the aerial tree as well.
        -- Only works when manage_folds = true
        link_folds_to_tree = false,

        -- Fold code when you open/collapse symbols in the tree.
        -- Only works when manage_folds = true
        link_tree_to_folds = true,

        -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
        -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
        nerd_font = 'auto',

        -- Call this function when aerial attaches to a buffer.
        on_attach = function(bufnr) end,

        -- Call this function when aerial first sets symbols on a buffer.
        on_first_symbols = function(bufnr) end,

        -- Automatically open aerial when entering supported buffers.
        -- This can be a function (see :help aerial-open-automatic)
        open_automatic = false,

        -- Run this command after jumping to a symbol (false will disable)
        post_jump_cmd = 'normal! zz',

        -- Invoked after each symbol is parsed, can be used to modify the parsed item,
        -- or to filter it by returning false.
        --
        -- bufnr: a neovim buffer number
        -- item: of type aerial.Symbol
        -- ctx: a record containing the following fields:
        --   * backend_name: treesitter, lsp, man...
        --   * lang: info about the language
        --   * symbols?: specific to the lsp backend
        --   * symbol?: specific to the lsp backend
        --   * syntax_tree?: specific to the treesitter backend
        --   * match?: specific to the treesitter backend, TS query match
        post_parse_symbol = function(bufnr, item, ctx)
          return true
        end,

        -- Invoked after all symbols have been parsed and post-processed,
        -- allows to modify the symbol structure before final display
        --
        -- bufnr: a neovim buffer number
        -- items: a collection of aerial.Symbol items, organized in a tree,
        --        with 'parent' and 'children' fields
        -- ctx: a record containing the following fields:
        --   * backend_name: treesitter, lsp, man...
        --   * lang: info about the language
        --   * symbols?: specific to the lsp backend
        --   * syntax_tree?: specific to the treesitter backend
        post_add_all_symbols = function(bufnr, items, ctx)
          return items
        end,

        -- When true, aerial will automatically close after jumping to a symbol
        close_on_select = true,

        -- The autocmds that trigger symbols update (not used for LSP backend)
        update_events = 'TextChanged,InsertLeave',

        -- Show box drawing characters for the tree hierarchy
        show_guides = false,

        -- Customize the characters used when show_guides = true
        guides = {
          -- When the child item has a sibling below it
          mid_item = '├─',
          -- When the child item is the last in the list
          last_item = '└─',
          -- When there are nested child guides to the right
          nested_top = '│ ',
          -- Raw indentation
          whitespace = '  ',
        },

        -- Set this function to override the highlight groups for certain symbols
        get_highlight = function(symbol, is_icon)
          -- return "MyHighlight" .. symbol.kind
        end,

        -- Options for opening aerial in a floating win
        float = {
          border = 'rounded',
          relative = 'win',

          -- These control the height of the floating window.
          -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_height and max_height can be a list of mixed types.
          -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
          height = 0.5,

          override = function(conf, source_winid)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
        },

        -- Options for the floating nav windows
        nav = {
          border = 'rounded',
          width = 0.5,
          win_opts = {
            cursorline = true,
            winblend = 10,
          },
          -- Jump to symbol in source window when the cursor moves
          autojump = false,
          -- Show a preview of the code in the right column, when there are no child symbols
          preview = false,
          -- Keymaps in the nav window
          keymaps = {
            ['<CR>'] = 'actions.jump',
            ['<2-LeftMouse>'] = 'actions.jump',
            ['<C-v>'] = 'actions.jump_vsplit',
            ['<C-s>'] = 'actions.jump_split',
            ['h'] = 'actions.left',
            ['l'] = 'actions.right',
            ['<C-c>'] = 'actions.close',
          },
        },

        lsp = {
          -- Fetch document symbols when LSP diagnostics update.
          -- If false, will update on buffer changes.
          diagnostics_trigger_update = true,

          -- Set to false to not update the symbols when there are LSP errors
          update_when_errors = true,

          -- How long to wait (in ms) after a buffer change before updating
          -- Only used when diagnostics_trigger_update = false
          update_delay = 300,

          -- Map of LSP client name to priority. Default value is 10.
          -- Clients with higher (larger) priority will be used before those with lower priority.
          -- Set to -1 to never use the client.
          priority = {
            -- pyright = 10,
          },
        },

        treesitter = {
          -- How long to wait (in ms) after a buffer change before updating
          update_delay = 300,
        },

        markdown = {
          -- How long to wait (in ms) after a buffer change before updating
          update_delay = 300,
        },

        man = {
          -- How long to wait (in ms) after a buffer change before updating
          update_delay = 300,
        },
      }
    end,
  },
}
