local icons = require 'tobin.icons'
return {
  {
    'folke/neodev.nvim',
    lazy = false,
    priority = 1000,
    event = 'UiEnter',
  },
  {
    'stevearc/aerial.nvim',
    cmd = { 'AerialNavOpen' },
    opts = {
      nav = {
        border = 'rounded',
        max_height = 0.9,
        min_height = { 10, 0.1 },
        max_width = 0.5,
        min_width = { 0.2, 20 },
        win_opts = {
          cursorline = true,
          winblend = 10,
        },
        filter_kind = false,
        autojump = true,
        preview = true,
        keymaps = {
          ['q'] = 'actions.close',
          ['<CR>'] = 'actions.jump',
          ['<2-LeftMouse>'] = 'actions.jump',
          ['<C-v>'] = 'actions.jump_vsplit',
          ['<C-s>'] = 'actions.jump_split',
          ['h'] = 'actions.left',
          ['l'] = 'actions.right',
        },
      },

      lsp = {
        diagnostics_trigger_update = true,
        update_when_errors = true,
        update_delay = 300,
        priority = {
          copilot = -1,
        },
      },
      layout = { min_width = 28 },
      show_guides = false,
      filter_kind = false,
      guides = {
        mid_item = '├ ',
        last_item = '└ ',
        nested_top = '│ ',
        whitespace = '  ',
      },
      keymaps = {
        ['q'] = 'actions.close',
        ['[y'] = 'actions.prev',
        [']y'] = 'actions.next',
        ['[Y'] = 'actions.prev_up',
        [']Y'] = 'actions.next_up',
        ['{'] = false,
        ['}'] = false,
        ['[['] = false,
        [']]'] = false,
      },
    },
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
          'lua-language-server',
          'bash-language-server',
          'tsserver',
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
          'vimls',
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
          --- @param bufnr number
          on_attach = function(_, bufnr)
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
}
