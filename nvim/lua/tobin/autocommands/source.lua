vim.cmd [[
augroup vimscript_source
  au!
  au BufWritePost,FileWritePost *.vim,~/.vimrc,~/.vim/vimrc source <afile>
augroup END
]]
