local utils = require 'tobin.utils.keymap'

--- @param desc string
-- local desc = function(desc)
--   return { noremap = true, silent = true, desc = desc }
-- end

vim.g.mapleader = ' '

if not table.unpack then
  table.unpack = unpack
end

local maps = { i = {}, n = {}, v = {}, t = {} }

-- Nvim Tree
maps.n['<leader>pv'] = { '<CMD>NvimTreeFocus<CR>', desc = 'Focus Nvim-Tree' }

-- Splits
maps.n['|'] = { '<CMD>FocusSplitLeft<CR>', desc = 'Splits Left' }
maps.n['-'] = { '<CMD>FocusSplitDown<CR>', desc = 'Splits Down' }

-- Copilot
vim.g.copilot_no_tab_map = true

-- Lazy git
maps.n['<leader>lg'] = { '<CMD>LazyGit<CR>', desc = 'Lazy Git' }

-- Telescope
maps.n['<leader>fa'] = { '<CMD>lua require"telescope.builtin".find_files()<CR>', desc = 'Telescope Find All Files' }
maps.n['<leader>fi'] = { '<CMD>Telescope lsp_incoming_calls<CR>', desc = 'Telescope Find All Files' }
maps.n['<leader>fu'] = { '<CMD>lua require("telescope").extensions.undo.undo()<CR>', desc = 'Telescope Find All Files' }

maps.n['<leader>ff'] =
  { '<CMD>lua require"telescope.builtin".find_files{ cwd = pwd } <CR>', desc = 'Telescope Smart File Finder' }
maps.n['<leader>fg'] = { '<CMD>lua require"telescope.builtin".live_grep()<CR>', desc = 'Telescope Grep Files' }
maps.n['<leader>fr'] = { '<CMD>lua require"telescope.builtin".oldfiles()<CR>', desc = 'Telescope Find Old Files' }

-- Trouble
maps.n['<leader>tt'] = { '<cmd>TroubleToggle<cr>', desc = 'Toggle Trouble' }
maps.n['<leader>ta'] = { '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Toggle Trouble Workspace Diagnostics' }
maps.n['<leader>td'] = { '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Toggle Trouble Document Diagnostics' }
maps.n['<leader>tq'] = { '<cmd>TroubleToggle quickfix<cr>', desc = 'Toggle Trouble Quickfix' }

maps.n['trouble'] =
  { "<cmd>require('trouble').next({ skip_groups = true, jump = true });<cr>", desc = 'Next Entrie (Trouble)' }
maps.n['trouble'] =
  { "require('trouble').previous({ skip_groups = true, jump = true });", desc = 'Previous Entrie (Trouble)' }
maps.n['trouble'] =
  { "require('trouble').first({ skip_groups = true, jump = true });", desc = 'Top Of Entries (Trouble)' }
maps.n['trouble'] =
  { "require('trouble').last({ skip_groups = true, jump = true });", desc = 'Bottom Of Entries (Trouble)' }

-- Live Server
maps.n['<leader>mls'] = { '<CMD>LiveServerStart<CR>', desc = 'Start HTML Live Server' }

-- Terminal
maps.n['<leader>mt'] = { '<CMD>Lspsaga term_toggle<CR>', desc = 'Toggle Terminal' }
maps.n['<ESC>h'] = { '<CMD>Lspsaga term_toggle<CR>', desc = 'Close Terminal' }
-- maps.t['<ESC>h'] = { '<CMD>Lspsaga term_toggle<CR>', desc = 'Close Terminal' }

-- Hop
maps.n['<leader>hh'] = { '<CMD>HopWord<CR>', desc = 'Hop Word' }
maps.n['<C-h><C-w>'] = { '<CMD>HopWord<CR>', desc = 'Hop Word' }
maps.n['<S-CR>'] = { '<CMD>HopWord<CR>', desc = 'Hop Word' }
maps.n['<S-Enter>'] = { '<CMD>HopWord<CR>', desc = 'Hop Word' }
maps.n['<leader>hl'] = { '<CMD>HopWordCurrentLine<CR>', desc = 'Hop Word In Current Line' }

-- Moving lines
maps.n['<A-j>'] = { ':m .+1<CR>==' }
maps.n['<A-k>'] = { ':m .-2<CR>==' }
maps.i['<A-j>'] = { '<Esc>:m .+1<CR>==gi' }
maps.i['<A-k>'] = { '<Esc>:m .-2<CR>==gi' }
maps.v['<A-j>'] = { ':m >+1<CR>gv=gv' }
maps.v['<A-k>'] = { ':m <-2<CR>gv=gv' }
maps.v['<A-k>'] = { ':m <-2<CR>gv=gv' }
maps.v['<A-j>'] = { ':m >+1<CR>gv=gv' }

maps.n['<C-M><C-j>'] = { ':m .+1<CR>==' }
maps.n['<C-M><C-k>'] = { ':m .-2<CR>==' }
maps.i['<C-M><C-j>'] = { '<Esc>:m .+1<CR>==gi' }
maps.i['<C-M><C-k>'] = { '<Esc>:m .-2<CR>==gi' }
maps.v['<C-M><C-j>'] = { ':m >+1<CR>gv=gv' }
maps.v['<C-M><C-k>'] = { ':m <-2<CR>gv=gv' }
maps.v['<C-M><C-j>'] = { ':m >+1<CR>gv=gv' }
maps.v['<C-M><C-k>'] = { ':m <-2<CR>gv=gv' }

maps.n['<leader>ha'] = { '<CMD>HopAnywhereCurrentLine<CR>', desc = 'Hop Word Anywhere In Current Line' }
maps.n['<leader>hs'] = { '<CMD>HopChar2<CR>', desc = 'Hop Word (2 Characters)' }

-- Misc Settings
maps.n['<leader>mh'] = { '<CMD>noh<CR>ColorizerReloadAllBuffers<CR>', desc = 'Clears Highlighting' }
maps.n['<leader>fml'] = { '<CMD>CellularAutomaton make_it_rain<CR>', desc = 'Makes It Rain' }
-- vim.cmd [[cnoremap <expr> w (getcmdtype() ==# ':' && getcmdline() ==# 'w') ? 'w!' : 'w']]

maps.n['<leader>mc'] = { '<CMD>e ~/.config/nvim/init.lua<CR><CMD>cd %:p:h<CR>', desc = 'Edits init.lua' }
maps.n['<leader>ml'] = {
  '<CMD>InstantStartServer 0.0.0.0 8080<CR><CMD>InstantStartSession 0.0.0.0 8080<CR><CMD>TermExec cmd=\'ngrok --log=stdout tcp 8080 | grep -o "tcp://.*.ngrok.io:[0-9]*"\'<CR>',
  desc = 'Starts A Live Server In ToggleTerm Terminal',
}
maps.n['<leader>md'] = { '<CMD>cd %:p:h<CR>', desc = 'Set Current Directory To The Current File' }

-- Neovide
if vim.g.neovide then
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  maps.n['<D-s>'] = { ':w<CR>', desc = 'Cool' }
  maps.v['<D-c>'] = { '"+y', desc = 'Cool' }
  maps.n['<D-v>'] = { '"+P', desc = 'Cool' }
  maps.v['<D-v>'] = { '"+P', desc = 'Cool' }
  maps.c['<D-v>'] = { '<C-R>+, desc = "Cool' }
  maps.i['<D-v>'] = { '<ESC>l"+Pli', desc = 'Cool' }
  maps.i['<D-h>'] = { '<C-w>h', desc = 'Cool' }
  maps.n['<D-j>'] = { '<C-w>j', desc = 'Cool' }
  maps.i['<D-l>'] = { '<C-w>l', desc = 'Cool' }
  maps.i['<D-k>'] = { '<C-w>k', desc = 'Cool' }
  maps.i['<D-h>'] = { '<C-w>h', desc = 'Cool' }
  maps.i['<D-j>'] = { '<C-w>j', desc = 'Cool' }
  maps.i['<D-l>'] = { '<C-w>l', desc = 'Cool' }
  maps.i['<D-k>'] = { '<C-w>k', desc = 'Cool' }
end

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
maps.n['<D-v>'] = { '+p<CR>', desc = 'Cool' }
maps.t['<D-v>'] = { '<C-R>+', desc = 'Cool' }
maps.v['<D-v>'] = { '<C-R>+', desc = 'Cool' }
-- Spotify
maps.n['<leader>sn'] = { '<Plug>(SpotifySkip)', desc = 'Cool' }
maps.n['<leader>sp'] = { '<Plug>(SpotifyPause)', desc = 'Cool' }
maps.n['<leader>ss'] = { '<Plug>(SpotifySave)', desc = 'Cool' }
maps.n['<leader>so'] = { '<CMD>Spotify<CR>', desc = 'OGCool' }
maps.n['<leader>sb'] = { '<Plug>(SpotifyPrev)', desc = 'Cool' }
maps.n['<leader>sh'] = { '<Plug>(SpotifyShuffle)', desc = 'Coolio' }

-- Misc
maps.n['<leader>d0'] = { 'd^', desc = 'Delete Until First Character' }
maps.n['<leader>c0'] = { 'c^', desc = 'Cut Until First Character' }
maps.n['<leader>mp'] = { '<Cmd>TogglePreview<CR>', desc = 'Starts a live preview of markdown or tex' }
maps.i['˙'] = { '<C-<Left>>' }
maps.i['∆'] = { '<C-<Down>>' }
maps.i['˚'] = { '<C-<Up>>' }
maps.i['¬'] = { '<C-<Right>>' }
maps.n['˙'] = { '<C-<Left>>' }
maps.n['∆'] = { '<C-<Down>>' }
maps.n['˚'] = { '<C-<Up>>' }
maps.n['¬'] = { '<C-<Right>>' }

-- Trailblazer
maps.n['<leader>em'] = { '<Cmd>TrailBlazerNewTrailMark<CR>', desc = 'Trailblazer make mark' }
maps.n['<leader>ek'] = { '<Cmd>TrailBlazerPeekMovePreviousUp<CR>', desc = 'Trailblazer Previous Mark' }
maps.n['<leader>ej'] = { '<Cmd>TrailBlazerPeekMoveNextDown<CR>', desc = 'Trailblazer Down Mark' }
maps.n['<leader>eb'] = { '<Cmd>TrailBlazerTrackBack<CR>', desc = 'Trailblazer Down Mark' }
maps.n['<leader>ed'] = { '<Cmd>TrailBlazerDeleteAllTrailMarks<CR>', desc = 'Trailblazer Delete All Marks' }

-- LSP
maps.n['<leader>gy'] = { '<CMD>AerialNavOpen<CR>' }
maps.n['<leader>lr'] = { '<CMD>LspRestart<CR>', desc = 'Restart Lsp Server' }
maps.n['<leader>ga'] = { '<Cmd>Lspsaga code_action<CR>', desc = 'Lsp Code Action' }
-- maps.n[':IncRename '] = {
--   function()
--     return ':IncRename ' .. vim.fn.expand '<cword>'
--   end,
--   { expr = true },
-- }

maps.n['<leader>gp'] = { '<Cmd>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' }
maps.n['<leader>gf'] = { '<Cmd>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' }
-- maps.n['lsp_signature'] = {
--   function()
--     require('lsp_signature').toggle_float_win()
--   end,
--   desc = 'Cool',
-- }
maps.n['Jump to definition'] = { vim.lsp.buf.definition, desc = 'Jump to definition' }
maps.n['gh'] = { '<Cmd>Lspsaga lsp_finder<CR>' }
maps.v['<leader>ca'] = { '<Cmd>Lspsaga code_action<CR>' }
maps.n['<leader>ca'] = { '<Cmd>Lspsaga code_action<CR>' }
maps.n['gp'] = { '<Cmd>Lspsaga peek_definition<CR>' }
maps.n['gd'] = { '<Cmd>Lspsaga goto_definition<CR>' }
maps.n['gt'] = { '<Cmd>Lspsaga peek_type_definition<CR>' }
maps.n['gt'] = { '<Cmd>Lspsaga goto_type_definition<CR>' }
maps.n['<leader>sl'] = { '<Cmd>Lspsaga show_line_diagnostics<CR>' }
maps.n['<leader>sb'] = { '<Cmd>Lspsaga show_buf_diagnostics<CR>' }
maps.n['<leader>sw'] = { '<Cmd>Lspsaga show_workspace_diagnostics<CR>' }
maps.n['<leader>sc'] = { '<Cmd>Lspsaga show_cursor_diagnostics<CR>' }
maps.n['[e'] = { '<Cmd>Lspsaga diagnostic_jump_prev<CR>' }
maps.n[']e'] = { '<Cmd>Lspsaga diagnostic_jump_next<CR>' }
-- maps.n['[E'] = {
--   function()
--     require('lspsaga.diagnostic'):goto_prev { severity = vim.diagnostic.severity.ERROR }
--   end,
-- }
-- maps.n[']E'] = {
--   function()
--     require('lspsaga.diagnostic'):goto_next { severity = vim.diagnostic.severity.ERROR }
--   end,
-- }
maps.n['<leader>go'] = { '<Cmd>Lspsaga outline<CR>' }
maps.n['K'] = { '<Cmd>Lspsaga hover_doc<CR>' }
maps.n['[d'] = { vim.diagnostic.goto_prev }
maps.n[']d'] = { vim.diagnostic.goto_next() }

maps.n['<leader>ga'] = { '<CMD>Lspsaga code_action<CR>', desc = 'Lsp Code Action' }
maps.n['<leader>gp'] = { '<CMD>Lspsaga peek_definition<CR>', desc = 'Lsp Rename' }
maps.n['Jump To Definition'] = { vim.lsp.buf.definition, desc = 'Cool' }

-- Buffers
maps.n['<Leader>bn'] = { '<Cmd>BufferLineCycleNext<CR>', desc = 'Go To Next Buffer' }
maps.n['<Leader>bb'] = { '<Cmd>BufferLineCyclePrev<CR>', desc = 'Go To Previous Buffer' }
maps.n['<Leader>bc'] = { '<Cmd>bd<CR>', desc = 'Close Current Buffer' }
maps.n['<Leader>bh'] = { '<Cmd>BufferLineMovePrev<CR>', desc = 'Close Current Buffer' }
maps.n['<Leader>bl'] = { '<Cmd>BufferLineMoveNext<CR>', desc = 'Close Current Buffer' }
maps.n['<Leader>bv'] = { '<CMD>wa!<CR><CMD>Wipeout<CR>', desc = 'Close All Buffers Except Visible' }
maps.n['<leader>b1'] = { '<Cmd>BufferLineGoToBuffer 1<CR>', desc = 'Go To Buffer 1' }
maps.n['<leader>b2'] = { '<Cmd>BufferLineGoToBuffer 2<CR>', desc = 'Go To Buffer 2' }
maps.n['<leader>b3'] = { '<Cmd>BufferLineGoToBuffer 3<CR>', desc = 'Go To Buffer 3' }
maps.n['<leader>b4'] = { '<Cmd>BufferLineGoToBuffer 4<CR>', desc = 'Go To Buffer 4' }
maps.n['<leader>b5'] = { '<Cmd>BufferLineGoToBuffer 5<CR>', desc = 'Go To Buffer 5' }
maps.n['<leader>b8'] = { '<Cmd>BufferLineGoToBuffer 8<CR>', desc = 'Go To Buffer 8' }

utils.set_mappings(maps)
-- utils.set_mappings(astronvim.user_desc("mappings", maps))
