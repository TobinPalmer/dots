vim.cmd [[
   au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
]]

vim.cmd [[
  augroup filetype
    au! BufRead,BufNewFile *.swift set ft=swift
  augroup END
]]
