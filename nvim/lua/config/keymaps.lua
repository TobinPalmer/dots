local Util = require("lazyvim.util")
local map = vim.keymap.set

map("n", "<leader>ga", vim.lsp.buf.code_action, { silent = true })
map("n", "<leader>gr", vim.lsp.buf.rename, { silent = true })

local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end

map("n", "<leader>mt", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>mT", function()
  Util.terminal()
end, { desc = "Terminal (cwd)" })

map("n", "<leader>nd", function()
  require("notify").dismiss({ pending = true, silent = true })
end, { desc = "Dismiss all messages" })