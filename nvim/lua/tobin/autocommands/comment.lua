vim.cmd [[
  augroup disable_comment_continuation
    autocmd!
    autocmd FileType * setlocal formatoptions-=cro
    autocmd FileType * setlocal comments-=:#
  augroup END
]]

vim.cmd [["Highlighting]]
vim.cmd [[
" No highlighting
]]
