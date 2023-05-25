--- @param desc string
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

vim.g.mapleader = ' '
local keymap = vim.keymap.set

if not table.unpack then
  table.unpack = unpack
end

-- Nvim Tree
keymap('n', '<leader>pv', '<CMD>NvimTreeFocus<CR>', opts 'Focus Nvim-Tree')

-- Splits
keymap('n', '|', '<CMD>FocusSplitLeft<CR>', opts 'Splits Left')
keymap('n', '-', '<CMD>FocusSplitDown<CR>', opts 'Splits Down')

-- Copilot
vim.g.copilot_no_tab_map = true

-- Lazy git
keymap('n', '<leader>lg', '<CMD>LazyGit<CR>', opts 'Lazy Git')

-- Telescope
keymap('n', '<leader>fa', '<CMD>lua require"telescope.builtin".find_files()<CR>', opts 'Telescope Find All Files')
keymap('n', '<leader>fi', '<CMD>Telescope lsp_incoming_calls<CR>', opts 'Telescope Find All Files')
keymap('n', '<leader>fu', '<CMD>lua require("telescope").extensions.undo.undo()<CR>', opts 'Telescope Find All Files')

-- keymap("n", "zR", require("ufo").openAllFolds)
-- keymap("n", "zM", require("ufo").closeAllFolds)
keymap(
  'n',
  '<leader>ff',
  '<CMD>lua require"telescope.builtin".find_files{ cwd = pwd } <CR>',
  opts 'Telescope Smart File Finder'
)
keymap('n', '<leader>fg', '<CMD>lua require"telescope.builtin".live_grep()<CR>', opts 'Telescope Grep Files')
keymap('n', '<leader>fr', '<CMD>lua require"telescope.builtin".oldfiles()<CR>', opts 'Telescope Find Old Files')

-- Trouble
keymap('n', '<leader>tt', '<cmd>TroubleToggle<cr>', opts 'Toggle Trouble')
keymap('n', '<leader>ta', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts 'Toggle Trouble Workspace Diagnostics')
keymap('n', '<leader>td', '<cmd>TroubleToggle document_diagnostics<cr>', opts 'Toggle Trouble Document Diagnostics')
keymap('n', '<leader>tq', '<cmd>TroubleToggle quickfix<cr>', opts 'Toggle Trouble Quickfix')

keymap(
  'n',
  '<leader>tj',
  "<cmd>require('trouble').next({ skip_groups = true, jump = true });<cr>",
  opts 'Next Entrie (Trouble)'
)
keymap(
  'n',
  '<leader>tk',
  "require('trouble').previous({ skip_groups = true, jump = true });",
  opts 'Previous Entrie (Trouble)'
)
keymap(
  'n',
  '<leader>tgg',
  "require('trouble').first({ skip_groups = true, jump = true });",
  opts 'Top Of Entries (Trouble)'
)
keymap(
  'n',
  '<leader>tG',
  "require('trouble').last({ skip_groups = true, jump = true });",
  opts 'Bottom Of Entries (Trouble)'
)
-- Live Server
keymap('n', '<leader>mls', '<CMD>LiveServerStart<CR>', opts 'Start HTML Live Server')

-- Terminal
keymap('n', '<leader>mt', '<CMD>Lspsaga term_toggle<CR>', opts 'Toggle Terminal')
keymap({ 't', 'n' }, '<ESC>h', '<CMD>Lspsaga term_toggle<CR>', opts 'Close Terminal')

-- Line Folding
keymap('n', '<leader>mf', 'za', opts 'Toggle Fold')

-- Hop
keymap('n', '<leader>hh', '<CMD>HopWord<CR>', opts 'Hop Word')
keymap('n', '<C-h><C-w>', '<CMD>HopWord<CR>', opts 'Hop Word')
keymap('n', '<S-CR>', '<CMD>HopWord<CR>', opts 'Hop Word')
keymap('n', '<S-Enter>', '<CMD>HopWord<CR>', opts 'Hop Word')
keymap('n', '<leader>hl', '<CMD>HopWordCurrentLine<CR>', opts 'Hop Word In Current Line')

-- Moving lines
keymap({ 'n' }, '<A-j>', ':m .+1<CR>==')
keymap({ 'n' }, '<A-k>', ':m .-2<CR>==')
keymap({ 'i' }, '<A-j>', '<Esc>:m .+1<CR>==gi')
keymap({ 'i' }, '<A-k>', '<Esc>:m .-2<CR>==gi')
keymap({ 'v', 'x' }, '<A-j>', ':m >+1<CR>gv=gv')
keymap({ 'v', 'x' }, '<A-k>', ':m <-2<CR>gv=gv')

keymap({ 'n' }, '<C-M><C-j>', ':m .+1<CR>==')
keymap({ 'n' }, '<C-M><C-k>', ':m .-2<CR>==')
keymap({ 'i' }, '<C-M><C-j>', '<Esc>:m .+1<CR>==gi')
keymap({ 'i' }, '<C-M><C-k>', '<Esc>:m .-2<CR>==gi')
keymap({ 'v', 'x' }, '<C-M><C-j>', ':m >+1<CR>gv=gv')
keymap({ 'v', 'x' }, '<C-M><C-k>', ':m <-2<CR>gv=gv')

keymap('n', '<leader>ha', '<CMD>HopAnywhereCurrentLine<CR>', opts 'Hop Word Anywhere In Current Line')
keymap('n', '<leader>hs', '<CMD>HopChar2<CR>', opts 'Hop Word (2 Characters)')

-- Misc Settings
keymap('n', '<leader>mh', '<CMD>noh<CR>ColorizerReloadAllBuffers<CR>', opts 'Clears Highlighting')
keymap('n', '<leader>fml', '<CMD>CellularAutomaton make_it_rain<CR>', opts 'Makes It Rain')
vim.cmd [[cnoremap <expr> w (getcmdtype() ==# ':' && getcmdline() ==# 'w') ? 'w!' : 'w']]

keymap('n', '<leader>mc', '<CMD>e ~/.config/nvim/init.lua<CR><CMD>cd %:p:h<CR>', opts 'Edits init.lua')
keymap(
  'n',
  '<leader>ml',
  '<CMD>InstantStartServer 0.0.0.0 8080<CR><CMD>InstantStartSession 0.0.0.0 8080<CR><CMD>TermExec cmd=\'ngrok --log=stdout tcp 8080 | grep -o "tcp://.*.ngrok.io:[0-9]*"\'<CR>',
  opts 'Starts A Live Server In ToggleTerm Terminal'
)
keymap('n', '<leader>md', '<CMD>cd %:p:h<CR>', opts 'Set Current Directory To The Current File')

-- Neovide
if vim.g.neovide then
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  vim.keymap.set({ 'n', 'i' }, '<D-h>', '<C-w>h') -- Paste normal mode
  vim.keymap.set({ 'n', 'i' }, '<D-j>', '<C-w>j') -- Paste normal mode
  vim.keymap.set({ 'n', 'i' }, '<D-l>', '<C-w>l') -- Paste normal mode
  vim.keymap.set({ 'n', 'i' }, '<D-k>', '<C-w>k') -- Paste normal mode
end

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

-- Spotify
vim.api.nvim_set_keymap('n', '<leader>sn', '<Plug>(SpotifySkip)', { silent = true }) -- Skip the current track
vim.api.nvim_set_keymap('n', '<leader>sp', '<Plug>(SpotifyPause)', { silent = true }) -- Pause/Resume the current track
vim.api.nvim_set_keymap('n', '<leader>ss', '<Plug>(SpotifySave)', { silent = true }) -- Add the current track to your library
vim.api.nvim_set_keymap('n', '<leader>so', ':Spotify<CR>', { silent = true }) -- Open Spotify Search window
vim.api.nvim_set_keymap('n', '<leader>sb', '<Plug>(SpotifyPrev)', { silent = true }) -- Go back to the previous track
vim.api.nvim_set_keymap('n', '<leader>sh', '<Plug>(SpotifyShuffle)', { silent = true }) -- Toggles shuffle mode

-- Misc
keymap('n', '<leader>d0', 'd^', opts 'Delete Until First Character')
keymap('n', '<leader>c0', 'c^', opts 'Cut Until First Character')
keymap('n', '<leader>mp', '<Cmd>TogglePreview<CR>', opts 'Starts a live preview of markdown or tex')

keymap('i', '˙', '<C-<Left>>')
keymap('i', '∆', '<C-<Down>>')
keymap('i', '˚', '<C-<Up>>')
keymap('i', '¬', '<C-<Right>>')

keymap('n', '˙', '<C-<Left>>')
keymap('n', '∆', '<C-<Down>>')
keymap('n', '˚', '<C-<Up>>')
keymap('n', '¬', '<C-<Right>>')

-- Trailblazer
keymap('n', '<leader>em', '<Cmd>TrailBlazerNewTrailMark<CR>', opts 'Trailblazer make mark')
keymap('n', '<leader>ek', '<Cmd>TrailBlazerPeekMovePreviousUp<CR>', opts 'Trailblazer Previous Mark')
keymap('n', '<leader>ej', '<Cmd>TrailBlazerPeekMoveNextDown<CR>', opts 'Trailblazer Down Mark')
keymap('n', '<leader>eb', '<Cmd>TrailBlazerTrackBack<CR>', opts 'Trailblazer Down Mark')
keymap('n', '<leader>ed', '<Cmd>TrailBlazerDeleteAllTrailMarks<CR>', opts 'Trailblazer Delete All Marks')

-- LSP
keymap('n', '<leader>gy', '<CMD>AerialNavOpen<CR>')
keymap('n', '<leader>lr', '<CMD>LspRestart<CR>', { silent = true })
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<leader>ga', '<Cmd>Lspsaga code_action<CR>', opts 'Lsp Code Action')
vim.keymap.set('n', '<leader>gr', function()
  return ':IncRename ' .. vim.fn.expand '<cword>'
end, { expr = true })

keymap('n', '<leader>gp', '<Cmd>Lspsaga peek_definition<CR>', opts 'Lsp Rename')
keymap('n', '<leader>gf', '<Cmd>Lspsaga peek_definition<CR>', opts 'Lsp Rename')
keymap('n', '<leader>gs', function()
  require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'Toggle Signature' })
keymap('n', '<leader>gd', vim.lsp.buf.definition, opts 'Jump to definition')
keymap('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>')
keymap({ 'n', 'v' }, '<leader>ca', '<Cmd>Lspsaga code_action<CR>')
keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>')
keymap('n', 'gd', '<Cmd>Lspsaga goto_definition<CR>')
keymap('n', 'gt', '<Cmd>Lspsaga peek_type_definition<CR>')
keymap('n', 'gt', '<Cmd>Lspsaga goto_type_definition<CR>')
keymap('n', '<leader>sl', '<Cmd>Lspsaga show_line_diagnostics<CR>')
keymap('n', '<leader>sb', '<Cmd>Lspsaga show_buf_diagnostics<CR>')
keymap('n', '<leader>sw', '<Cmd>Lspsaga show_workspace_diagnostics<CR>')
keymap('n', '<leader>sc', '<Cmd>Lspsaga show_cursor_diagnostics<CR>')
keymap('n', '[e', '<Cmd>Lspsaga diagnostic_jump_prev<CR>')
keymap('n', ']e', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
keymap('n', '[E', function()
  require('lspsaga.diagnostic'):goto_prev { severity = vim.diagnostic.severity.ERROR }
end)
keymap('n', ']E', function()
  require('lspsaga.diagnostic'):goto_next { severity = vim.diagnostic.severity.ERROR }
end)
keymap('n', '<leader>go', '<Cmd>Lspsaga outline<CR>')
keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>')
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<leader>q', vim.diagnostic.setloclist)
keymap('n', '<leader>ga', '<CMD>Lspsaga code_action<CR>', opts 'Lsp Code Action')
keymap('n', '<leader>gp', '<CMD>Lspsaga peek_definition<CR>', opts 'Lsp Rename')
keymap('n', '<leader>gs', function()
  require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'Toggle Signature' })
keymap('n', '<leader>gd', vim.lsp.buf.definition, { silent = true, noremap = true, desc = 'Jump To Definition' })

-- Buffers
keymap('n', '<Leader>bn', '<Cmd>BufferLineCycleNext<CR>', opts 'Go To Next Buffer')
keymap('n', '<Leader>bb', '<Cmd>BufferLineCyclePrev<CR>', opts 'Go To Previous Buffer')
keymap('n', '<Leader>bc', '<Cmd>bd<CR>', opts 'Close Current Buffer')
keymap('n', '<Leader>bh', '<Cmd>BufferLineMovePrev<CR>', opts 'Close Current Buffer')
keymap('n', '<Leader>bl', '<Cmd>BufferLineMoveNext<CR>', opts 'Close Current Buffer')
keymap('n', '<Leader>bv', '<CMD>wa!<CR><CMD>Wipeout<CR>', opts 'Close All Buffers Except Visible')

keymap('n', '<leader>b1', '<Cmd>BufferLineGoToBuffer 1<CR>', opts 'Go To Buffer 1')
keymap('n', '<leader>b2', '<Cmd>BufferLineGoToBuffer 2<CR>', opts 'Go To Buffer 2')
keymap('n', '<leader>b3', '<Cmd>BufferLineGoToBuffer 3<CR>', opts 'Go To Buffer 3')
keymap('n', '<leader>b4', '<Cmd>BufferLineGoToBuffer 4<CR>', opts 'Go To Buffer 4')
keymap('n', '<leader>b5', '<Cmd>BufferLineGoToBuffer 5<CR>', opts 'Go To Buffer 5')
keymap('n', '<leader>b8', '<Cmd>BufferLineGoToBuffer 8<CR>', opts 'Go To Buffer 8')
keymap('n', '<leader>b6', '<Cmd>BufferLineGoToBuffer 6<CR>', opts 'Go To Buffer 6')
keymap('n', '<leader>b7', '<Cmd>BufferLineGoToBuffer 7<CR>', opts 'Go To Buffer 7')
