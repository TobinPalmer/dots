local utils = require 'tobin.utils.keymap'

vim.g.mapleader = ' '

if not table.unpack then
  table.unpack = unpack
end

MAPS = { i = {}, n = {}, v = {}, t = {} }

-- Nvim Tree
MAPS.n['<leader>pv'] = { '<CMD>NvimTreeFocus<CR>', desc = 'Focus Nvim-Tree' }

-- Splits
MAPS.n['|'] = { '<CMD>FocusSplitLeft<CR>', desc = 'Splits Left' }
MAPS.n['-'] = { '<CMD>FocusSplitDown<CR>', desc = 'Splits Down' }

-- Copilot
vim.g.copilot_no_tab_map = true

-- Lazy git
MAPS.n['<leader>lg'] = { '<CMD>LazyGit<CR>', desc = 'Lazy Git' }

-- Telescope
MAPS.n['<leader>fa'] = { '<CMD>lua require"telescope.builtin".find_files()<CR>', desc = 'Telescope Find All Files' }
MAPS.n['<leader>fi'] = { '<CMD>Telescope lsp_incoming_calls<CR>', desc = 'Telescope Find All Files' }
MAPS.n['<leader>fu'] = { '<CMD>lua require("telescope").extensions.undo.undo()<CR>', desc = 'Telescope Find All Files' }

MAPS.n['<leader>ff'] = { '<CMD>FzfLua files<CR>', desc = 'Telescope Smart File Finder' }
MAPS.n['<leader>fg'] = { '<CMD>lua require"telescope.builtin".live_grep()<CR>', desc = 'Telescope Grep Files' }
MAPS.n['<leader>fr'] = { '<CMD>lua require"telescope.builtin".oldfiles()<CR>', desc = 'Telescope Find Old Files' }

-- Trouble
MAPS.n['<leader>tt'] = { '<cmd>TroubleToggle<cr>', desc = 'Toggle Trouble' }
MAPS.n['<leader>ta'] = { '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Toggle Trouble Workspace Diagnostics' }
MAPS.n['<leader>td'] = { '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Toggle Trouble Document Diagnostics' }
MAPS.n['<leader>tq'] = { '<cmd>TroubleToggle quickfix<cr>', desc = 'Toggle Trouble Quickfix' }

MAPS.n['trouble'] =
  { "<cmd>require('trouble').next({ skip_groups = true, jump = true });<cr>", desc = 'Next Entrie (Trouble)' }
MAPS.n['trouble'] =
  { "require('trouble').previous({ skip_groups = true, jump = true });", desc = 'Previous Entrie (Trouble)' }
MAPS.n['trouble'] =
  { "require('trouble').first({ skip_groups = true, jump = true });", desc = 'Top Of Entries (Trouble)' }
MAPS.n['trouble'] =
  { "require('trouble').last({ skip_groups = true, jump = true });", desc = 'Bottom Of Entries (Trouble)' }

-- Live Server
MAPS.n['<leader>mls'] = { '<CMD>LiveServerStart<CR>', desc = 'Start HTML Live Server' }

-- Terminal
MAPS.n['<leader>mt'] = { '<CMD>Lspsaga term_toggle<CR>', desc = 'Toggle Terminal' }
MAPS.n['<ESC>h'] = { '<CMD>Lspsaga term_toggle<CR>', desc = 'Close Terminal' }
-- MAPS.t['<ESC>h'] = { '<CMD>Lspsaga term_toggle<CR>', desc = 'Close Terminal' }

-- Hop
MAPS.n['<leader>hh'] = { '<CMD>HopWord<CR>', desc = 'Hop Word' }
MAPS.n['<C-h><C-w>'] = { '<CMD>HopWord<CR>', desc = 'Hop Word' }
MAPS.n['<S-CR>'] = { '<CMD>HopWord<CR>', desc = 'Hop Word' }
MAPS.n['<S-Enter>'] = { '<CMD>HopWord<CR>', desc = 'Hop Word' }
MAPS.n['<leader>hl'] = { '<CMD>HopWordCurrentLine<CR>', desc = 'Hop Word In Current Line' }

-- Moving lines
MAPS.n['<A-j>'] = { ':m .+1<CR>==' }
MAPS.n['<A-k>'] = { ':m .-2<CR>==' }
MAPS.i['<A-j>'] = { '<Esc>:m .+1<CR>==gi' }
MAPS.i['<A-k>'] = { '<Esc>:m .-2<CR>==gi' }
MAPS.v['<A-j>'] = { ':m >+1<CR>gv=gv' }
MAPS.v['<A-k>'] = { ':m <-2<CR>gv=gv' }
MAPS.v['<A-k>'] = { ':m <-2<CR>gv=gv' }
MAPS.v['<A-j>'] = { ':m >+1<CR>gv=gv' }

MAPS.n['<C-M><C-j>'] = { ':m .+1<CR>==' }
MAPS.n['<C-M><C-k>'] = { ':m .-2<CR>==' }
MAPS.i['<C-M><C-j>'] = { '<Esc>:m .+1<CR>==gi' }
MAPS.i['<C-M><C-k>'] = { '<Esc>:m .-2<CR>==gi' }
MAPS.v['<C-M><C-j>'] = { ':m >+1<CR>gv=gv' }
MAPS.v['<C-M><C-k>'] = { ':m <-2<CR>gv=gv' }
MAPS.v['<C-M><C-j>'] = { ':m >+1<CR>gv=gv' }
MAPS.v['<C-M><C-k>'] = { ':m <-2<CR>gv=gv' }

MAPS.n['<leader>ha'] = { '<CMD>HopAnywhereCurrentLine<CR>', desc = 'Hop Word Anywhere In Current Line' }
MAPS.n['<leader>hs'] = { '<CMD>HopChar2<CR>', desc = 'Hop Word (2 Characters)' }

-- Misc Settings
MAPS.n['<leader>mh'] = { '<CMD>noh<CR>ColorizerReloadAllBuffers<CR>', desc = 'Clears Highlighting' }
MAPS.n['<leader>fml'] = { '<CMD>CellularAutomaton make_it_rain<CR>', desc = 'Makes It Rain' }
-- vim.cmd [[cnoremap <expr> w (getcmdtype() ==# ':' && getcmdline() ==# 'w') ? 'w!' : 'w']]

MAPS.n['<leader>mc'] = { '<CMD>e ~/.config/nvim/init.lua<CR><CMD>cd %:p:h<CR>', desc = 'Edits init.lua' }
MAPS.n['<leader>ml'] = {
  '<CMD>InstantStartServer 0.0.0.0 8080<CR><CMD>InstantStartSession 0.0.0.0 8080<CR><CMD>TermExec cmd=\'ngrok --log=stdout tcp 8080 | grep -o "tcp://.*.ngrok.io:[0-9]*"\'<CR>',
  desc = 'Starts A Live Server In ToggleTerm Terminal',
}

MAPS.n['<leader>md'] = { '<CMD>cd %:p:h<CR>', desc = 'Set Current Directory To The Current File' }

-- Neovide
if vim.g.neovide then
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  MAPS.n['<D-s>'] = { ':w<CR>', desc = 'Cool' }
  MAPS.v['<D-c>'] = { '"+y', desc = 'Cool' }
  MAPS.n['<D-v>'] = { '"+P', desc = 'Cool' }
  MAPS.v['<D-v>'] = { '"+P', desc = 'Cool' }
  MAPS.c['<D-v>'] = { '<C-R>+, desc = "Cool' }
  MAPS.i['<D-v>'] = { '<ESC>l"+Pli', desc = 'Cool' }
  MAPS.i['<D-h>'] = { '<C-w>h', desc = 'Cool' }
  MAPS.n['<D-j>'] = { '<C-w>j', desc = 'Cool' }
  MAPS.i['<D-l>'] = { '<C-w>l', desc = 'Cool' }
  MAPS.i['<D-k>'] = { '<C-w>k', desc = 'Cool' }
  MAPS.i['<D-h>'] = { '<C-w>h', desc = 'Cool' }
  MAPS.i['<D-j>'] = { '<C-w>j', desc = 'Cool' }
  MAPS.i['<D-l>'] = { '<C-w>l', desc = 'Cool' }
  MAPS.i['<D-k>'] = { '<C-w>k', desc = 'Cool' }
end

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
MAPS.n['<D-v>'] = { '+p<CR>', desc = 'Cool' }
MAPS.t['<D-v>'] = { '<C-R>+', desc = 'Cool' }
MAPS.v['<D-v>'] = { '<C-R>+', desc = 'Cool' }
-- Spotify
MAPS.n['<leader>sn'] = { '<Plug>(SpotifySkip)', desc = 'Cool' }
MAPS.n['<leader>sp'] = { '<Plug>(SpotifyPause)', desc = 'Cool' }
MAPS.n['<leader>ss'] = { '<Plug>(SpotifySave)', desc = 'Cool' }
MAPS.n['<leader>so'] = { '<CMD>Spotify<CR>', desc = 'OGCool' }
MAPS.n['<leader>sb'] = { '<Plug>(SpotifyPrev)', desc = 'Cool' }
MAPS.n['<leader>sh'] = { '<Plug>(SpotifyShuffle)', desc = 'Coolio' }

-- Misc
MAPS.n['<leader>d0'] = { 'd^', desc = 'Delete Until First Character' }
MAPS.n['<leader>c0'] = { 'c^', desc = 'Cut Until First Character' }
MAPS.n['<leader>mp'] = { '<Cmd>TogglePreview<CR>', desc = 'Starts a live preview of markdown or tex' }
MAPS.i['˙'] = { '<C-<Left>>' }
MAPS.i['∆'] = { '<C-<Down>>' }
MAPS.i['˚'] = { '<C-<Up>>' }
MAPS.i['¬'] = { '<C-<Right>>' }
MAPS.n['˙'] = { '<C-<Left>>' }
MAPS.n['∆'] = { '<C-<Down>>' }
MAPS.n['˚'] = { '<C-<Up>>' }
MAPS.n['¬'] = { '<C-<Right>>' }

-- Trailblazer
MAPS.n['<leader>em'] = { '<Cmd>TrailBlazerNewTrailMark<CR>', desc = 'Trailblazer make mark' }
MAPS.n['<leader>ek'] = { '<Cmd>TrailBlazerPeekMovePreviousUp<CR>', desc = 'Trailblazer Previous Mark' }
MAPS.n['<leader>ej'] = { '<Cmd>TrailBlazerPeekMoveNextDown<CR>', desc = 'Trailblazer Down Mark' }
MAPS.n['<leader>eb'] = { '<Cmd>TrailBlazerTrackBack<CR>', desc = 'Trailblazer Down Mark' }
MAPS.n['<leader>ed'] = { '<Cmd>TrailBlazerDeleteAllTrailMarks<CR>', desc = 'Trailblazer Delete All Marks' }

-- LSP
MAPS.n['<leader>gy'] = { '<CMD>AerialNavOpen<CR>' }
MAPS.n['<leader>lr'] = { '<CMD>LspRestart<CR>', desc = 'Restart Lsp Server' }
MAPS.n['<leader>ga'] = { '<Cmd>Lspsaga code_action<CR>', desc = 'Lsp Code Action' }
-- MAPS.n[':IncRename '] = {
--   function()
--     return ':IncRename ' .. vim.fn.expand '<cword>'
--   end,
--   { expr = true },
-- }

MAPS.n['<leader>gp'] = { '<Cmd>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' }
MAPS.n['<leader>gf'] = { '<Cmd>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' }
-- MAPS.n['lsp_signature'] = {
--   function()
--     require('lsp_signature').toggle_float_win()
--   end,
--   desc = 'Cool',
-- }
MAPS.n['Jump to definition'] = { vim.lsp.buf.definition, desc = 'Jump to definition' }
MAPS.n['gh'] = { '<Cmd>Lspsaga lsp_finder<CR>' }
MAPS.v['<leader>ca'] = { '<Cmd>Lspsaga code_action<CR>' }
MAPS.n['<leader>ca'] = { '<Cmd>Lspsaga code_action<CR>' }
MAPS.n['gp'] = { '<Cmd>Lspsaga peek_definition<CR>' }
MAPS.n['gd'] = { '<Cmd>Lspsaga goto_definition<CR>' }
MAPS.n['gt'] = { '<Cmd>Lspsaga peek_type_definition<CR>' }
MAPS.n['gt'] = { '<Cmd>Lspsaga goto_type_definition<CR>' }
MAPS.n['<leader>sl'] = { '<Cmd>Lspsaga show_line_diagnostics<CR>' }
MAPS.n['<leader>sb'] = { '<Cmd>Lspsaga show_buf_diagnostics<CR>' }
MAPS.n['<leader>sw'] = { '<Cmd>Lspsaga show_workspace_diagnostics<CR>' }
MAPS.n['<leader>sc'] = { '<Cmd>Lspsaga show_cursor_diagnostics<CR>' }
MAPS.n['[e'] = { '<Cmd>Lspsaga diagnostic_jump_prev<CR>' }
MAPS.n[']e'] = { '<Cmd>Lspsaga diagnostic_jump_next<CR>' }
-- MAPS.n['[E'] = {
--   function()
--     require('lspsaga.diagnostic'):goto_prev { severity = vim.diagnostic.severity.ERROR }
--   end,
-- }
-- MAPS.n[']E'] = {
--   function()
--     require('lspsaga.diagnostic'):goto_next { severity = vim.diagnostic.severity.ERROR }
--   end,
-- }

MAPS.n['<leader>go'] = { '<Cmd>Lspsaga outline<CR>' }
MAPS.n['K'] = { '<Cmd>Lspsaga hover_doc<CR>' }
MAPS.n['[d'] = { vim.diagnostic.goto_prev }
MAPS.n[']d'] = { vim.diagnostic.goto_next }
MAPS.n['<leader>ga'] = { '<CMD>Lspsaga code_action<CR>', desc = 'Lsp Code Action' }
MAPS.n['<leader>gp'] = { '<CMD>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' }
MAPS.n['Jump To Definition'] = { vim.lsp.buf.definition, desc = 'Cool' }

-- Buffers
MAPS.n['<Leader>bn'] = { '<Cmd>BufferLineCycleNext<CR>', desc = 'Go To Next Buffer' }
MAPS.n['<Leader>bb'] = { '<Cmd>BufferLineCyclePrev<CR>', desc = 'Go To Previous Buffer' }
MAPS.n['<Leader>bc'] = { '<Cmd>bd<CR>', desc = 'Close Current Buffer' }
MAPS.n['<Leader>bh'] = { '<Cmd>BufferLineMovePrev<CR>', desc = 'Close Current Buffer' }
MAPS.n['<Leader>bl'] = { '<Cmd>BufferLineMoveNext<CR>', desc = 'Close Current Buffer' }
MAPS.n['<Leader>bv'] = { '<CMD>wa!<CR><CMD>Wipeout<CR>', desc = 'Close All Buffers Except Visible' }
MAPS.n['<leader>b1'] = { '<Cmd>BufferLineGoToBuffer 1<CR>', desc = 'Go To Buffer 1' }
MAPS.n['<leader>b2'] = { '<Cmd>BufferLineGoToBuffer 2<CR>', desc = 'Go To Buffer 2' }
MAPS.n['<leader>b3'] = { '<Cmd>BufferLineGoToBuffer 3<CR>', desc = 'Go To Buffer 3' }
MAPS.n['<leader>b4'] = { '<Cmd>BufferLineGoToBuffer 4<CR>', desc = 'Go To Buffer 4' }
MAPS.n['<leader>b5'] = { '<Cmd>BufferLineGoToBuffer 5<CR>', desc = 'Go To Buffer 5' }
MAPS.n['<leader>b8'] = { '<Cmd>BufferLineGoToBuffer 8<CR>', desc = 'Go To Buffer 8' }

utils.set_mappings(MAPS)
