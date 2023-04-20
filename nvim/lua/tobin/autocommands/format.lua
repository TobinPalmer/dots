vim.cmd [[autocmd BufWritePost *.{ts,js} silent! EslintFixAll]]
vim.cmd [[autocmd BufWritePost *.py lua vim.lsp.buf.format()]]
