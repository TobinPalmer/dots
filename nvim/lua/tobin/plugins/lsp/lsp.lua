return {
  {
    'folke/neodev.nvim',
    lazy = false,
    priority = 1000,
    event = 'UiEnter',
  },
  {
    'akinsho/flutter-tools.nvim',
    ft = 'dart',
    event = 'BufReadPost',
    keys = {
      { '<leader>fr', '<CMD>FlutterRestart<CR>', desc = 'Restart Flutter' },
      { '<leader>fo', '<CMD>FlutterOutline<CR>', desc = 'Flutter Outline' },
      { '<leader>fs', '<CMD>FlutterRun -d MacOS<CR>', desc = 'Run Flutter' },
      {
        '<leader>fa',
        function()
          vim.cmd [[norm! mq]]
          vim.cmd [[FlutterRestart]]
          vim.cmd [[wa!]]
          vim.cmd [[e!]]
          vim.cmd [[norm! `q]]
        end,
        desc = 'Run Flutter',
      },
    },
    config = function()
      require('flutter-tools').setup {
        widget_guides = {
          enabled = true,
        },
        dev_log = {
          enabled = true,
          notify_errors = false, -- if there is an error whilst running then notify the user
          open_cmd = 'edit', -- command to use to open the log buffer
        },
      }
    end,
  },
  {
    {
      'ray-x/lsp_signature.nvim',
      event = 'LspAttach',
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
          -- 'tsserver',
          'prettierd',
          'stylua',
          'markdownlint',
          'shellcheck',
          'write-good',
          'yamllint',
        },
      },
    },
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'ray-x/lsp_signature.nvim',
        'RRethy/vim-illuminate',
        'b0o/schemastore.nvim',
        {
          'SmiteshP/nvim-navbuddy',
          keys = {
            { '<leader>gy', '<CMD>Navbuddy<CR>', desc = 'Toggle NavBuddy' },
          },
          dependencies = {
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
          },
          opts = { lsp = { auto_attach = true } },
        },
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
          'pyright',
          'cssls',
          'bashls',
          'vimls',
          'texlab',
          'dartls',
          'yamlls',
          'html',
          'jsonls',
          'marksman',
        }

        for _, lsp in pairs(servers) do
          lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end

        lspconfig['ocamllsp'].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { 'ocamllsp' },
          filetypes = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' },
          root_dir = lspconfig.util.root_pattern(
            '*.opam',
            'esy.json',
            'package.json',
            '.git',
            'dune-project',
            'dune-workspace'
          ),
        }

        lspconfig['jsonls'].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        }

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

        -- lspconfig['tsserver'].setup {
        --   on_attach = on_attach,
        --   capabilities = capabilities,
        --   settings = {
        --     javascript = {
        --       inlayHints = {
        --         includeInlayEnumMemberValueHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayVariableTypeHints = true,
        --       },
        --     },
        --     typescript = {
        --       inlayHints = {
        --         includeInlayEnumMemberValueHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayVariableTypeHints = true,
        --       },
        --     },
        --   },
        -- }

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
            -- nls.builtins.formatting.prettierd.with {
            --   disabled_filetypes = { 'markdown', 'yaml' },
            -- },
          },
        }
      end,
    },
  },
}
