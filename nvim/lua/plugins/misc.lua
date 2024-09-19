local leet_arg = "leetcode.nvim"

return {
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
    keys = {
      { "K", "<CMD>lua require('pretty_hover').hover()<CR>", desc = "Hover (pretty)" },
      { "<leader>pk", "<CMD>lua require('pretty_hover').hover()<CR>", desc = "Hover (pretty)" },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
  },
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", "<Plug>(dial-increment)", mode = { "n", "v" } },
      { "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "v" } },
      { "g<C-a>", "g<Plug>(dial-increment)", mode = { "n", "v" } },
      { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" } },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.constant.alias.bool, -- boolean value (true <-> false)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/18, etc.)
          augend.date.alias["%m/%d/%Y"], -- date (02/19/2022)
          -- augend.date.alias["%m-%d-%Y"], -- date (02-19-2022)
          -- augend.date.alias["%Y-%m-%d"], -- date (02-19-2022)
          augend.date.new({
            pattern = "%m.%d.%Y",
            default_kind = "day",
            only_valid = true,
            word = false,
          }),
          augend.misc.alias.markdown_header,
        },
      })
    end,
  },
  { "wakatime/vim-wakatime", lazy = false },
  {
    "andweeb/presence.nvim",
    lazy = false,
    config = function()
      require("presence").setup({
        auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text = "Neovim",
        main_image = "neovim", -- Main image display (either "neovim" or "file")

        -- Rich Presence text options
        editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
      })
    end,
  },
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv()[1],
    build = ":TSUpdate html",
    keys = {
      { "<leader>lr", "<CMD>Leet run<CR>", desc = "Run LeetCode" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",
    },
    opts = {
      arg = leet_arg,

      ---@type lc.lang
      lang = "typescript",

      hooks = {
        ---@type fun()[]
        LeetEnter = {
          function()
            vim.cmd("Copilot disable")
          end,
        },

        ---@type fun(question: { lang: string })[]
        LeetQuestionNew = {},
      },
    },
  },
  {
    "TobinPalmer/Tip.nvim",
    enabled = false,
    event = "VimEnter",
    init = function()
      --- @type Tip.config
      require("tip").setup({
        title = "Tip!",
        -- url = "https://vtip.43z.one",
        url = "https://vimiscool.tech/neotip",
      })
    end,
  },
  {
    "TobinPalmer/rayso.nvim",
    cmd = { "Rayso" },
    enabled = false,
    config = function()
      require("rayso").setup({
        base_url = "https://ray.so/",
        options = {
          padding = 0,
          background = false,
          theme = "candy",
        },
        -- options = {
        --   background = true,
        --   dark_mode = true,
        --   theme = "breeze",
        --   logging_enabled = true,
        --   logging_path = "/Users/tobin/Documents/Rayso/"
        --   logging_file = "rayso",
        --   title = "nexxai",
        --   padding = 32,
        -- },
      })
    end,
  },
  {
    "TobinPalmer/pastify.nvim",
    cmd = { "Pastify" },
    config = function()
      require("pastify").setup({
        opts = {
          apikey = "YOUR API KEY (https://api.imgbb.com/)", -- Needed if you want to save online.
        },
      })
    end,
  },
}
