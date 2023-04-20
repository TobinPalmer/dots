require('toggleterm').setup {
  size = 20,
  hide_numbers = true,
  autochdir = false,
  highlights = {
    NormalFloat = {
      link = 'Normal',
    },
  },
  on_open = function(term)
    vim.cmd 'startinsert!'
  end,
  -- function to run on closing the terminal
  on_close = function()
    vim.cmd 'startinsert!'
  end,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = 'float',
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = 'curved',
    width = function()
      return math.floor(vim.o.columns * 0.9)
    end,
    height = function()
      return math.floor((vim.o.lines - vim.o.cmdheight) * 0.9)
    end,
    winblend = 3,
    zindex = 1,
  },
}
