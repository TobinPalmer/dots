return {
  "axelvc/template-string.nvim",
  event = "InsertEnter",
  ft = { "javascript", "typescript", "typescriptreact" },
  opts = {
    remove_template_string = true, -- remove backticks when there are no template strings
  },
}
