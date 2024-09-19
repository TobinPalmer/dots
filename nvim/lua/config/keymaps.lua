local Util = require("lazyvim.util")
local map = vim.keymap.set

map("n", "<leader>ga", vim.lsp.buf.code_action, { silent = true })
map("n", "<leader>gr", vim.lsp.buf.rename, { silent = true })
vim.keymap.set("n", "<leader>ql", function()
  require("persistence").load({ last = true })
end)

local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end

map("n", "<leader>mt", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>mT", function()
  Util.terminal()
end, { desc = "Terminal (cwd)" })

map("n", "|", "<CMD>vsplit<CR>", { desc = "New vertical split" })
