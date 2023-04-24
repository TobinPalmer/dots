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
          'cssls',
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
    {
      'SmiteshP/nvim-navbuddy',
      event = 'LspAttach',
      dependencies = {
        'SmiteshP/nvim-navic',
        'MunifTanjim/nui.nvim',
      },
      keys = {
        {
          '<leader>lt',
          function()
            require('nvim-navbuddy').open()
          end,
          desc = 'Navbuddy open',
        },
      },
      opts = {
        window = {
          border = 'rounded',
          size = '80%',
          position = '50%',
        },
        icons = {
          Namespace = ' ',
          Package = ' ',
          String = ' ',
          Number = ' ',
          Boolean = '◩ ',
          Array = ' ',
          Object = ' ',
          Key = ' ',
          Null = 'ﳠ ',
          Method = 'm ',
          Function = ' ',
          Constructor = ' ',
          Field = ' ',
          Variable = ' ',
          Class = 'ﴯ ',
          Interface = ' ',
          Module = ' ',
          Property = ' ',
          Enum = ' ',
          File = ' ',
          EnumMember = ' ',
          Constant = ' ',
          Struct = '  ',
          Event = ' ',
          Operator = ' ',
          TypeParameter = ' ',
        },
      },
    },
  },
}
