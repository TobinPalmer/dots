local set = vim.opt
local g = vim.g

g.mapleader = ','
g.maplocalleader = ','

set.nu = true
set.relativenumber = true
set.autochdir = false

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.hlsearch = false
set.incsearch = true
set.scrolloff = 10

set.splitbelow = true
set.splitright = true
set.signcolumn = 'yes'
set.showmode = false

set.timeout = true
set.timeoutlen = 200

set.smartindent = true
set.wrap = false
set.termguicolors = true
set.list = false

set.swapfile = false
set.backup = false
set.undodir = os.getenv 'HOME' .. '/.vim/undodir'
set.undofile = true
set.undolevels = 10000
set.mousemoveevent = true

-- UFO folding
set.foldcolumn = '1' -- '0' is not bad
set.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
set.foldlevelstart = 99
set.foldenable = true
set.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

if vim.g.neovide then
  g.neovide_scroll_animation_length = 0.2
  g.neovide_input_macos_alt_is_meta = true
  g.neovide_floating_blur_amount_x = 2.0
  g.neovide_floating_blur_amount_y = 2.0
  g.neovide_transparency = 0.93
  g.neovide_window_floating_blur = 0.5
  g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_scale_factor = 1.0

  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set('n', '<C-=>', function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set('n', '<C-->', function()
    change_scale_factor(1 / 1.25)
  end)
end

g.markdown_recommended_style = 0
set.laststatus = 0 -- Diable status on startup
vim.cmd [[set autoread | au CursorHold * checktime]]
set.nuw = 2
