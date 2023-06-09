-- npm install -g browser-sync
-- npm i -g vscode-langservers-extracted

return {
  'ray-x/web-tools.nvim',
  cmd = {
    'BrowserSync',
    'BrowserOpen',
    'BrowserPreview',
    'BrowserRestart',
    'Browserstop',
    'TagRename',
    'HurlRun',
  },
  keys = {
    { '<leader>mls', '<CMD>BrowserOpen<CR>' },
  },
  config = function()
    require('web-tools').setup {
      keymaps = {
        rename = nil, -- by default use same setup of lspconfig
        repeat_rename = '.', -- . to repeat
      },
      hurl = { -- hurl default
        show_headers = false, -- do not show http headers
        floating = false, -- use floating windows (need guihua.lua)
        formatters = { -- format the result by filetype
          json = { 'jq' },
          html = { 'prettier', '--parser', 'html' },
        },
      },
    }
  end,
}
