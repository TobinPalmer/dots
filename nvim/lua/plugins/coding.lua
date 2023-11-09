return {
  -- Automatic JS/TS template strings
  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    ft = { "javascript", "typescript", "typescriptreact" },
    opts = {
      remove_template_string = true, -- remove backticks when there are no template strings
    },
  },
  -- Surround text objects with characters
  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    init = function()
      require("nvim-surround").setup()
    end,
  },

  -- Auto pairing of quotes, brackets, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
