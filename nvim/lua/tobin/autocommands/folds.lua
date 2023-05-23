vim.cmd [[
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* silent! mkview %
  autocmd BufWinEnter *.* silent! loadview %
augroup END
]]
