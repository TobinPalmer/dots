vim.opt_local.formatoptions:remove({ "r", "o" })

local map = vim.keymap.set

-- Buffers
map("n", "<leader>bb", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "<leader>b1", '<CMD>lua require("bufferline").go_to(1, true)<CR>', { desc = "Go to buffer 1" })
map("n", "<leader>b2", '<CMD>lua require("bufferline").go_to(2, true)<CR>', { desc = "Go to buffer 2" })
map("n", "<leader>b3", '<CMD>lua require("bufferline").go_to(3, true)<CR>', { desc = "Go to buffer 3" })
map("n", "<leader>b4", '<CMD>lua require("bufferline").go_to(4, true)<CR>', { desc = "Go to buffer 4" })
map("n", "<leader>b5", '<CMD>lua require("bufferline").go_to(5, true)<CR>', { desc = "Go to buffer 5" })
map("n", "<leader>b6", '<CMD>lua require("bufferline").go_to(6, true)<CR>', { desc = "Go to buffer 6" })
map("n", "<leader>b7", '<CMD>lua require("bufferline").go_to(7, true)<CR>', { desc = "Go to buffer 7" })
map("n", "<leader>b8", '<CMD>lua require("bufferline").go_to(8, true)<CR>', { desc = "Go to buffer 8" })
map("n", "<leader>b9", '<CMD>lua require("bufferline").go_to(9, true)<CR>', { desc = "Go to buffer 9" })
map("n", "<leader>b$", '<CMD>lua require("bufferline").go_to(-1, true)<CR>', { desc = "Go to last buffer" })
