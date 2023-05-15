-- Disables comment continuation
vim.cmd [[
    autocmd!
    augroup disable_comment_continuation
    autocmd FileType * setlocal formatoptions-=cro
    autocmd FileType * setlocal comments-=:#
  augroup END
]]
