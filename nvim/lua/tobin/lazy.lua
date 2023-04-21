local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
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
  { 'onsails/lspkind.nvim', lazy = false },
  { 'folke/persistence.nvim', lazy = false },
  { 'nvim-treesitter/nvim-treesitter', event = 'BufWinEnter', lazy = true },
  { 'catppuccin/nvim', lazy = false, priority = 1000 },
  { 'gbprod/nord.nvim', lazy = false, priority = 1000 },
  { 'rose-pine/neovim', lazy = false, priority = 1000 },
  { 'hrsh7th/cmp-git', event = 'VeryLazy', lazy = true },
  { 'L3MON4D3/LuaSnip', event = 'VeryLazy', lazy = true },
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
  { 'hrsh7th/cmp-cmdline', event = 'VeryLazy', lazy = true },
  { 'jbyuki/instant.nvim', event = 'VeryLazy', lazy = true },
  { 'rstacruz/vim-closer', event = 'VeryLazy', lazy = true },
  { 'folke/which-key.nvim', event = 'VeryLazy', lazy = true },
  { 'hrsh7th/cmp-nvim-lsp', event = 'VeryLazy', lazy = true },
  { 'hrsh7th/cmp-nvim-lua', event = 'VeryLazy', lazy = true },
  { 'jcdickinson/wpm.nvim', event = 'VeryLazy', lazy = true },
  { 'wesleimp/stylua.nvim', event = 'VeryLazy', lazy = true },
  { 'LunarVim/bigfile.nvim', event = 'VeryLazy', lazy = true },
  { 'RRethy/vim-illuminate', event = 'VeryLazy', lazy = true },
  { 'echasnovski/mini.move', event = 'VeryLazy', lazy = true },
  { 'neovim/nvim-lspconfig', event = 'VeryLazy', lazy = true },
  { 'nvim-lua/plenary.nvim', event = 'VeryLazy', lazy = true },
  { 'CKolkey/ts-node-action', event = 'VeryLazy', lazy = true },
  { 'kylechui/nvim-surround', event = 'VeryLazy', lazy = true },
  { 'lewis6991/impatient.nvim', lazy = false, priority = 1001 },
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
  { 'terrortylor/nvim-comment', event = 'VeryLazy', lazy = true },
  { 'kyazdani42/nvim-web-devicons', lazy = false, priority = 998 },
  { 'danielfalk/smart-open.nvim', event = 'UIEnter', lazy = true },
  { 'nvim-telescope/telescope.nvim', event = 'VeryLazy', lazy = true },
  { 'weilbith/nvim-code-action-menu', event = 'VeryLazy', lazy = true },
  { 'wintermute-cell/gitignore.nvim', event = 'VeryLazy', lazy = true },
  { 'LeonHeidelbach/trailblazer.nvim', event = 'VeryLazy', lazy = true },
  { 'williamboman/mason-lspconfig.nvim', event = 'VeryLazy', lazy = true },
  { 'chrisgrieser/nvim-various-textobjs', event = 'VeryLazy', lazy = true },
  { 'antosha417/nvim-lsp-file-operations', event = 'VeryLazy', lazy = true },
  { 'lukas-reineke/indent-blankline.nvim', event = 'VeryLazy', lazy = true },
  { 'nvim-telescope/telescope-project.nvim', event = 'VeryLazy', lazy = true },
  { 'nvim-telescope/telescope-project.nvim', event = 'VeryLazy', lazy = true },
  { 'nvim-tree/nvim-tree.lua', lazy = true, event = 'VeryLazy', priority = 998 },
  { 'andymass/vim-matchup', lazy = true, event = 'VeryLazy' },
  { 'nathom/filetype.nvim' },

  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
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
      'barrett-ruth/import-cost.nvim',
      build = 'sh install.sh npm',
      lazy = true,
      event = 'BufWinEnter',
      config = true,
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
  root = vim.fn.stdpath 'data' .. '/lazy', -- directory where plugins will be installed
  defaults = {
    lazy = true, -- should plugins be lazy-loaded?
    -- default `cond` you can use to globally disable a lot of plugins
    -- when running inside vscode for example
    cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
    version = '*', -- enable this to try installing the latest stable versions of plugins
  },
  -- leave nil when passing the spec as the first argument to setup()
  spec = nil, ---@type LazySpec
  lockfile = vim.fn.stdpath 'config' .. '/lazy-lock.json', -- lockfile generated after running update.
  concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { '--since=3 days ago' }, -- show commits from the last 3 days
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = 'https://github.com/%s.git',
    -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
    -- then set the below to false. This should work, but is NOT supported and will
    -- increase downloads a lot.
    filter = true,
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { 'habamax' },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = 'none',
    icons = {
      cmd = ' ',
      config = '',
      event = '',
      ft = ' ',
      init = ' ',
      import = ' ',
      keys = ' ',
      lazy = '󰒲 ',
      loaded = '●',
      not_loaded = '○',
      plugin = ' ',
      runtime = ' ',
      source = ' ',
      start = '',
      task = '✔ ',
      list = {
        '●',
        '➜',
        '★',
        '‒',
      },
    },
    -- leave nil, to automatically select a browser depending on your OS.
    -- If you want to use a specific browser, you can define it here
    browser = nil, ---@type string?
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {
      -- you can define custom key maps here.
      -- To disable one of the defaults, set it to false

      -- open lazygit log
      ['<localleader>l'] = function(plugin)
        require('lazy.util').float_term({ 'lazygit', 'log' }, {
          cwd = plugin.dir,
        })
      end,
      -- open a terminal for the plugin dir
      ['<localleader>t'] = function(plugin)
        require('lazy.util').float_term(nil, {
          cwd = plugin.dir,
        })
      end,
    },
  },
  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = 'git',
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    enabled = true,
    root = vim.fn.stdpath 'state' .. '/lazy/readme',
    files = { 'README.md', 'lua/**/README.md' },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
  state = vim.fn.stdpath 'state' .. '/lazy/state.json', -- state info for checker and other things
}
