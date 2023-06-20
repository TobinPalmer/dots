local set = vim.opt

vim.g.copilot_no_tab_map = true
---@class opts
---@field nvim_tree nvim_tree
---@field bufferline bufferline
---@field lualine lualine
---@field use_icons boolean
---@field noice boolean
---@field minimal boolean
---@type opts

---@class bufferline
---@field style "slant" | "thin" | "thick"
---@type opts

---@class lualine
---@field style "line" | "jagged"
---@type opts

---@class nvim_tree
---@field float boolean
---@field close_on_select boolean
---@type opts

vim.g.opts = {
  minimal = false,
  use_icons = true,
  noice = false,
  bufferline = {
    style = 'slant',
  },
  lualine = {
    style = 'jagged',
  },
  nvim_tree = {
    float = true,
    close_on_select = true,
    close_on_exit = true,
  },
}

vim.g.notify_delay = 1500

vim.g.mapleader = ','
vim.g.maplocalleader = ','

set.nu = true
set.relativenumber = true
set.autochdir = false
set.tm = 500

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
set.timeoutlen = 500

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
-- set.foldcolumn = '1' -- '0' is not bad
set.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
set.foldlevelstart = 99
set.foldenable = true

if vim.g.neovide then
  vim.g.neovide_scroll_animation_length = 0.2
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_transparency = 0.93
  vim.g.neovide_window_floating_blur = 0.5
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_scale_factor = 1.0

  --- @param delta integer
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

vim.g.markdown_recommended_style = 0
set.laststatus = 0 -- Diable status on startup
vim.cmd [[set autoread | au CursorHold * checktime]]
set.nuw = 2
