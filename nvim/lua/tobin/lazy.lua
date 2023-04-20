local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

return require('lazy').setup {
  { 'zbirenbaum/copilot-cmp' },
  { 'zbirenbaum/copilot.lua' },
  { 'aznhe21/actions-preview.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'onsails/lspkind.nvim', lazy = true },
  { 'jedrzejboczar/possession.nvim', lazy = false },
  { 'nvim-treesitter/nvim-treesitter', lazy = false },
  { 'rose-pine/neovim', lazy = false, priority = 1000 },
  { 'hrsh7th/cmp-git', event = 'VeryLazy', lazy = true },
  { 'L3MON4D3/LuaSnip', event = 'VeryLazy', lazy = true },
  { 'ap/vim-css-color', event = 'VeryLazy', lazy = true },
  { 'axieax/typo.nvim', event = 'VeryLazy', lazy = true },
  { 'goolord/alpha-nvim', lazy = false, priority = 1000 },
  { 'hrsh7th/cmp-path', event = 'VeryLazy', lazy = true },
  { 'hrsh7th/cmp-path', event = 'VeryLazy', lazy = true },
  { 'hrsh7th/nvim-cmp', event = 'VeryLazy', lazy = true },
  { 'phaazon/hop.nvim', event = 'VeryLazy', lazy = true },
  { 'folke/neodev.nvim', event = 'VeryLazy', lazy = true },
  { 'folke/trouble.nvim', event = 'VeryLazy', lazy = true },
  { 'hrsh7th/cmp-buffer', event = 'VeryLazy', lazy = true },
  { 'hrsh7th/cmp-buffer', event = 'VeryLazy', lazy = true },
  { 'kkharji/sqlite.lua', event = 'VeryLazy', lazy = true },
  { 'ckipp01/stylua-nvim', event = 'VeryLazy', lazy = true },
  { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
  { 'catppuccin/nvim', lazy = false, priority = 1000 },
  { 'gbprod/nord.nvim', lazy = false, priority = 1000 },
  { 'hrsh7th/cmp-cmdline', event = 'VeryLazy', lazy = true },
  { 'jbyuki/instant.nvim', event = 'VeryLazy', lazy = true },
  { 'nvim-tree/nvim-tree.lua', lazy = true, event = 'VeryLazy', priority = 998 },
  { 'rstacruz/vim-closer', event = 'VeryLazy', lazy = true },
  { 'folke/which-key.nvim', event = 'VeryLazy', lazy = true },
  { 'hrsh7th/cmp-nvim-lsp', event = 'VeryLazy', lazy = true },
  { 'hrsh7th/cmp-nvim-lua', event = 'VeryLazy', lazy = true },
  { 'wesleimp/stylua.nvim', event = 'VeryLazy', lazy = true },
  { 'echasnovski/mini.move', event = 'VeryLazy', lazy = true },
  { 'neovim/nvim-lspconfig', event = 'VeryLazy', lazy = true },
  { 'terrortylor/nvim-comment', event = 'VeryLazy', lazy = true },
  { 'nvim-lua/plenary.nvim', event = 'VeryLazy', lazy = true },
  { 'CKolkey/ts-node-action', event = 'VeryLazy', lazy = true },
  { 'kylechui/nvim-surround', event = 'VeryLazy', lazy = true },
  { 'lewis6991/impatient.nvim', lazy = false, priority = 1001 },
  { 'mg979/vim-visual-multi', event = 'VeryLazy', lazy = true },
  { 'nvim-lualine/lualine.nvim', lazy = false, priority = 999 },
  { 'stevearc/dressing.nvim', event = 'VeryLazy', lazy = true },
  { 'akinsho/toggleterm.nvim', event = 'VeryLazy', lazy = true },
  { 'beauwilliams/focus.nvim', event = 'VeryLazy', lazy = true },
  { 'lewis6991/gitsigns.nvim', event = 'VeryLazy', lazy = true },
  { 'williamboman/mason.nvim', event = 'VeryLazy', lazy = true },
  { 'HiPhish/nvim-ts-rainbow2', event = 'VeryLazy', lazy = true },
  { 'dstein64/vim-startuptime', event = 'VeryLazy', lazy = true },
  { 'ray-x/lsp_signature.nvim', event = 'VeryLazy', lazy = true },
  { 'saadparwaiz1/cmp_luasnip', event = 'VeryLazy', lazy = true },
  { 'L3MON4D3/LuaSnip', event = 'VeryLazy', lazy = true },
  { 'kyazdani42/nvim-web-devicons', lazy = false, priority = 998 },
  { 'danielfalk/smart-open.nvim', event = 'VeryLazy', lazy = true },
  { 'nvim-telescope/telescope.nvim', event = 'VeryLazy', lazy = true },
  { 'wintermute-cell/gitignore.nvim', event = 'VeryLazy', lazy = true },
  { 'williamboman/mason-lspconfig.nvim', event = 'VeryLazy', lazy = true },
  { 'chrisgrieser/nvim-various-textobjs', event = 'VeryLazy', lazy = true },
  { 'antosha417/nvim-lsp-file-operations', event = 'VeryLazy', lazy = true },
  { 'nvim-telescope/telescope-project.nvim', event = 'VeryLazy', lazy = true },
  { 'nvim-telescope/telescope-project.nvim', event = 'VeryLazy', lazy = true },
  { 'lukas-reineke/indent-blankline.nvim', event = 'VeryLazy', lazy = true },
  { 'LeonHeidelbach/trailblazer.nvim', event = 'VeryLazy', lazy = true },
  { 'jcdickinson/wpm.nvim', event = 'VeryLazy', lazy = true },
  { 'LunarVim/bigfile.nvim', event = 'VeryLazy', lazy = true },
  { 'tamton-aquib/zone.nvim', event = 'VeryLazy', lazy = true },
  { 'RRethy/vim-illuminate', event = 'VeryLazy', lazy = true },
  { 'weilbith/nvim-code-action-menu', event = 'VeryLazy', lazy = true },

  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    {
      'barrett-ruth/import-cost.nvim',
      build = 'sh install.sh npm',
      config = true,
    },
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      dependencies = {
        { 'neovim/nvim-lspconfig' },
        {

          'williamboman/mason.nvim',
        },
        { 'williamboman/mason-lspconfig.nvim' },

        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
      },
    },
    {
      'romgrk/barbar.nvim',
      dependencies = 'kyazdani42/nvim-web-devicons',
      event = 'VeryLazy',
      lazy = true,
    },
    {
      'barrett-ruth/live-server.nvim',
      build = 'npm -g install live-server',
      config = true,
    },
  },
  -- {
  --           local buffer_alternate_target = group 'BufferAlternateTarget'
  --           local buffer_alternate =
  --             inject_underline('BufferAlternate', buffer_alternate_target, 'BufferAlternateTarget')
  --           set_hl(0, 'BufferAlternate', buffer_alternate)
  --           set_hl(0, 'BufferAlternateMod', extend_but_bg(buffer_alternate, group 'BufferAlternateMod'))
  --           set_hl(0, 'BufferAlternateTarget', extend_but_bg(buffer_alternate, buffer_alternate_target))
  --
  --           set_hl(0, 'BufferAlternateERROR', inject_fg(buffer_alternate, group('BufferAlternateERROR')[fg]))
  --           set_hl(0, 'BufferAlternateSign', inject_fg(buffer_alternate, buffer_tabpage_fill_bg))
  --           set_hl(0, 'BufferAlternateWARN', inject_fg(buffer_alternate, group('BufferAlternateWARN')[fg]))
  --         end
  --
  --         do
  --           local buffer_current_target = group 'BufferCurrentTarget'
  --           local buffer_current = inject_underline('BufferCurrent', buffer_current_target, 'BufferCurrentTarget')
  --           set_hl(0, 'BufferCurrent', buffer_current)
  --           set_hl(0, 'BufferCurrentMod', extend_but_bg(buffer_current, group 'BufferCurrentMod'))
  --           set_hl(0, 'BufferCurrentTarget', extend_but_bg(buffer_current, buffer_current_target))
  --
  --           set_hl(0, 'BufferCurrentERROR', inject_fg(buffer_current, group('BufferCurrentERROR')[fg]))
  --           set_hl(0, 'BufferCurrentSign', inject_fg(buffer_current, buffer_tabpage_fill_bg))
  --           set_hl(0, 'BufferCurrentWARN', inject_fg(buffer_current, group('BufferCurrentWARN')[fg]))
  --         end
  --
  --         do
  --           local buffer_inactive = group 'BufferInactive'
  --           set_hl(0, 'BufferInactive', buffer_inactive)
  --           set_hl(0, 'BufferInactiveSign', inject_fg(buffer_inactive, buffer_tabpage_fill_bg))
  --         end
  --
  --         do
  --           local buffer_visible_target = group 'BufferVisibleTarget'
  --           local buffer_visible = inject_underline('BufferVisible', buffer_visible_target, 'BufferVisibleTarget')
  --           set_hl(0, 'BufferVisible', buffer_visible)
  --           set_hl(0, 'BufferVisibleMod', extend_but_bg(buffer_visible, group 'BufferVisibleMod'))
  --           set_hl(0, 'BufferVisibleTarget', extend_but_bg(buffer_visible, buffer_visible_target))
  --
  --           set_hl(0, 'BufferVisibleERROR', inject_fg(buffer_visible, group('BufferVisibleERROR')[fg]))
  --           set_hl(0, 'BufferVisibleSign', inject_fg(buffer_visible, buffer_tabpage_fill_bg))
  --           set_hl(0, 'BufferVisibleWARN', inject_fg(buffer_visible, group('BufferVisibleWARN')[fg]))
  --         end
  --       end,
  --       group = 'config',
  --       pattern = 'highlite',
  --     })
  --   end,
  --   config = function()
  --     vim.api.nvim_command 'colorscheme highlite'
  --   end,
  --   priority = 1000,
  -- },
}
