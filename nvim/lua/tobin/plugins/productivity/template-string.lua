return {
  'axelvc/template-string.nvim',
  event = 'InsertEnter',
  config = function()
    require('template-string').setup {
      filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python' }, -- filetypes where the plugin is active
      jsx_brackets = true, -- must add brackets to jsx attributes
      remove_template_string = true, -- remove backticks when there are no template string
      restore_quotes = {
        normal = [[']],
        jsx = [[']],
      },
    }
  end,
}
