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
      build = ':MasonUpdate',
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
          'texlab',
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
          settings = {
            ['rust-analyzer'] = {
              procMacro = { enable = true },
              cargo = { allFeatures = true },
              checkOnSave = true,
              check = {},
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
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    event = 'LspAttach',
    config = function()
      require('aerial').setup {
        backends = { 'treesitter', 'lsp', 'markdown', 'man' },

        layout = {
          width = 0.5,
          win_opts = {},
          default_direction = 'prefer_right',
          placement = 'window',
          preserve_equality = false,
        },
        attach_mode = 'window',
        close_automatic_events = {},
        lazy_load = true,
        disable_max_lines = 10000,
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

        highlight_mode = 'split_width',

        highlight_closest = true,

        highlight_on_hover = false,

        highlight_on_jump = 300,

        autojump = false,

        icons = {},
        manage_folds = false,

        link_folds_to_tree = false,

        link_tree_to_folds = true,

        nerd_font = 'auto',

        close_on_select = true,

        update_events = 'textchanged,insertleave',

        show_guides = false,

        guides = {
          mid_item = '├─',
          last_item = '└─',
          nested_top = '│ ',
          whitespace = '  ',
        },

        get_highlight = function(symbol, is_icon) end,

        float = {
          border = 'rounded',
          relative = 'win',

          height = 0.5,

          override = function(conf, source_winid)
            return conf
          end,
        },

        nav = {
          border = 'rounded',
          width = 0.5,
          win_opts = {
            cursorline = true,
            winblend = 10,
          },
          autojump = false,
          preview = false,
          keymaps = {
            ['<cr>'] = 'actions.jump',
            ['<2-leftmouse>'] = 'actions.jump',
            ['<c-v>'] = 'actions.jump_vsplit',
            ['<c-s>'] = 'actions.jump_split',
            ['h'] = 'actions.left',
            ['l'] = 'actions.right',
            ['<c-c>'] = 'actions.close',
          },
        },

        lsp = {
          diagnostics_trigger_update = true,

          update_when_errors = true,

          update_delay = 300,

          priority = {},
        },

        treesitter = {
          update_delay = 300,
        },

        markdown = {
          update_delay = 300,
        },

        man = {
          update_delay = 300,
        },
      }
    end,
  },
}
