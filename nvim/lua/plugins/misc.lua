local leet_arg = "leetcode.nvim"

return {
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
    event = "VimEnter",
    init = function()
      --- @type Tip.config
      require("tip").setup({
        title = "Tip!",
        url = "https://vtip.43z.one",
      })
    end,
  },
}
