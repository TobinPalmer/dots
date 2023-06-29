return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'ray-x/lsp_signature.nvim',
    'RRethy/vim-illuminate',
  },
  event = 'BufReadPre',
  config = function()
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
    --         includeInlayParameterNameHints = 'all',
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
    --         includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all'
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
      cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
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
  require 'tobin.plugins.lsp.null_ls',
}
