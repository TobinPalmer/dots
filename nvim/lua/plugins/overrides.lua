local Util = require("lazyvim.util")
return {
  {
    "echasnovski/mini.comment",
    opts = {
      options = {
        ignore_blank_line = true,
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bc",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bC",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bb", "<cmd>bprevious<cr>", { desc = "Prev buffer" } },
      { "<leader>bv", "<cmd>BufferLineCloseOthers<cr>", { desc = "Prev buffer" } },
      { "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" } },
      { "<leader>b1", '<CMD>lua require("bufferline").go_to(1, true)<CR>', { desc = "Go to buffer 1" } },
      { "<leader>b2", '<CMD>lua require("bufferline").go_to(2, true)<CR>', { desc = "Go to buffer 2" } },
      { "<leader>b3", '<CMD>lua require("bufferline").go_to(3, true)<CR>', { desc = "Go to buffer 3" } },
      { "<leader>b4", '<CMD>lua require("bufferline").go_to(4, true)<CR>', { desc = "Go to buffer 4" } },
      { "<leader>b5", '<CMD>lua require("bufferline").go_to(5, true)<CR>', { desc = "Go to buffer 5" } },
      { "<leader>b6", '<CMD>lua require("bufferline").go_to(6, true)<CR>', { desc = "Go to buffer 6" } },
      { "<leader>b7", '<CMD>lua require("bufferline").go_to(7, true)<CR>', { desc = "Go to buffer 7" } },
      { "<leader>b8", '<CMD>lua require("bufferline").go_to(8, true)<CR>', { desc = "Go to buffer 8" } },
      { "<leader>b9", '<CMD>lua require("bufferline").go_to(9, true)<CR>', { desc = "Go to buffer 9" } },
      { "<leader>b$", '<CMD>lua require("bufferline").go_to(-1, true)<CR>', { desc = "Go to last buffer" } },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>pv",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>pg",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git explorer",
      },
      {
        "<leader>pb",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer explorer",
      },
    },
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      filesystem = {
        window = {
          mappings = {
            ["h"] = "close_node",
            ["l"] = "open",
          },
        },
      },
    },
  },
}
