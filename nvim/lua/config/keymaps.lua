local map = vim.keymap.set

map("n", "<leader>ga", vim.lsp.buf.code_action, { silent = true })
map("n", "<leader>gr", vim.lsp.buf.rename, { silent = true })
