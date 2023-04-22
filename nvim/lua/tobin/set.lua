local set = vim.opt
local g = vim.g

g.mapleader = ','
g.maplocalleader = ','

set.nu = true
set.relativenumber = true

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

g.markdown_recommended_style = 0
