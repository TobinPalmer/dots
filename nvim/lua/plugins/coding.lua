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

  {
    "gbprod/substitute.nvim",
    event = "InsertEnter",
    config = function()
      require("substitute").setup({})
      vim.keymap.del("n", "s")

      vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
      vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
      vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
      vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
      vim.keymap.set("n", "sx", require("substitute.exchange").operator, { noremap = true })
      vim.keymap.set("n", "sxx", require("substitute.exchange").line, { noremap = true })
      vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true })
      vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, { noremap = true })
    end,
    opts = {},
  },
  {
    "folke/trouble.nvim",
    opts = {
      auto_close = true,
    },
  },
}
