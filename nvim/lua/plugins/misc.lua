local leet_arg = "leetcode.nvim"

return {
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv()[1],
    build = ":TSUpdate html",
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
