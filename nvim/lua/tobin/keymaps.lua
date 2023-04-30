local normap = { noremap = true }
local noremap_silent = { noremap = true, silent = true }
vim.g.mapleader = ' '
local keymap = vim.keymap.set

if not table.unpack then
  table.unpack = unpack
end

-- Nvim Tree
keymap('n', '<leader>pv', '<CMD>NvimTreeFocus<CR>', { table.unpack(normap), desc = 'Focus Nvim-Tree' })

-- Splits
keymap('n', '|', '<CMD>FocusSplitLeft<CR>', { table.unpack(normap), desc = 'Splits Left' })
keymap('n', '-', '<CMD>FocusSplitDown<CR>', { table.unpack(normap), desc = 'Splits Down' })

-- Copilot
vim.g.copilot_no_tab_map = true

keymap('n', '<leader>lg', '<CMD>LazyGit<CR>', { table.unpack(normap), desc = 'Telescope Smart Telescope' })

-- Telescope
keymap(
  'n',
  '<leader>fa',
  '<CMD>lua require"telescope.builtin".find_files()<CR>',
  { table.unpack(normap), desc = 'Telescope Find All Files' }
)
keymap('n', '<leader>ff', '<CMD>Telescope smart_open<CR>', { table.unpack(normap), desc = 'Telescope Smart Telescope' })
keymap(
  'n',
  '<leader>fg',
  '<CMD>lua require"telescope.builtin".live_grep()<CR>',
  { table.unpack(normap), desc = 'Telescope Grep Files' }
)
keymap(
  'n',
  '<leader>fr',
  '<CMD>lua require"telescope.builtin".oldfiles()<CR>',
  { table.unpack(normap), desc = 'Telescope Find Old Files' }
)

-- Trouble
keymap('n', '<leader>tt', '<CMD>TroubleToggle<cr>', { table.unpack(noremap_silent), desc = 'Toggle Trouble' })
keymap(
  'n',
  '<leader>ta',
  '<CMD>TroubleToggle workspace_diagnostics<cr>',
  { table.unpack(noremap_silent), desc = 'Toggle Trouble Workspace Diagnostics' }
)
keymap(
  'n',
  '<leader>td',
  '<CMD>TroubleToggle document_diagnostics<cr>',
  { table.unpack(noremap_silent), desc = 'Toggle Trouble Document Diagnostics' }
)
keymap(
  'n',
  '<leader>tq',
  '<CMD>TroubleToggle quickfix<cr>',
  { table.unpack(noremap_silent), desc = 'Toggle Trouble Quickfix' }
)

keymap(
  'n',
  '<leader>tj',
  "<CMD>require('trouble').next({ skip_groups = true, jump = true });<cr>",
  { table.unpack(noremap_silent), desc = 'Next Entry (Trouble)' }
)
keymap(
  'n',
  '<leader>tk',
  "require('trouble').previous({ skip_groups = true, jump = true });",
  { table.unpack(noremap_silent), desc = 'Previous Entry (Trouble)' }
)
keymap(
  'n',
  '<leader>tgg',
  "require('trouble').first({ skip_groups = true, jump = true });",
  { table.unpack(noremap_silent), desc = 'Top Of Entries (Trouble)' }
)
keymap(
  'n',
  '<leader>tG',
  "require('trouble').last({ skip_groups = true, jump = true });",
  { table.unpack(noremap_silent), desc = 'Bottom Of Entries (Trouble)' }
)
-- Live Server
keymap(
  'n',
  '<leader>mls',
  '<CMD>LiveServerStart<CR>',
  { table.unpack(noremap_silent), desc = 'Start HTML Live Server' }
)

-- Terminal
keymap('n', '<leader>mt', '<CMD>Lspsaga term_toggle<CR>', { table.unpack(noremap_silent), desc = 'Toggle Terminal' })
keymap(
  { 't', 'n' },
  '<ESC>h',
  '<CMD>Lspsaga term_toggle<CR>',
  { noremap = true, silent = true, desc = 'Close Terminal' }
)

-- Line Folding
keymap('n', '<leader>mf', 'za', { table.unpack(noremap_silent), desc = 'Toggle Fold' })

-- Hop
keymap('n', '<leader>hh', '<CMD>HopWord<CR>', { table.unpack(noremap_silent), desc = 'Hop Word' })
keymap('n', '<S-CR>', '<CMD>HopWord<CR>', { table.unpack(noremap_silent), desc = 'Hop Word' })
keymap(
  'n',
  '<leader>hl',
  '<CMD>HopWordCurrentLine<CR>',
  { table.unpack(noremap_silent), desc = 'Hop Word In Current Line' }
)

-- Moving lines
keymap({ 'n' }, '<A-j>', ':m .+1<CR>==')
keymap({ 'n' }, '<A-k>', ':m .-2<CR>==')
keymap({ 'i' }, '<A-j>', '<Esc>:m .+1<CR>==gi')
keymap({ 'i' }, '<A-k>', '<Esc>:m .-2<CR>==gi')
keymap({ 'v', 'x' }, '<A-j>', ':m >+1<CR>gv=gv')
keymap({ 'v', 'x' }, '<A-k>', ':m <-2<CR>gv=gv')

keymap(
  'n',
  '<leader>ha',
  '<CMD>HopAnywhereCurrentLine<CR>',
  { table.unpack(noremap_silent), desc = 'Hop Word Anywhere In Current Line' }
)
keymap('n', '<leader>hs', '<CMD>HopChar2<CR>', { table.unpack(noremap_silent), desc = 'Hop Word (2 Characters)' })

-- Misc Settings
keymap('n', '<leader>mh', '<CMD>noh<CR>', { table.unpack(noremap_silent), desc = 'Clears Highlighting' })
-- vim.cmd [[cnoremap w w!]]
vim.cmd [[cnoremap <expr> w (getcmdtype() ==# ':' && getcmdline() ==# 'w') ? 'w!' : 'w']]

keymap(
  'n',
  '<leader>mc',
  '<CMD>e ~/.config/nvim/init.lua<CR><CMD>cd %:p:h<CR>',
  { table.unpack(noremap_silent), desc = 'Edits init.lua' }
)
keymap(
  'n',
  '<leader>ml',
  '<CMD>InstantStartServer 0.0.0.0 8080<CR><CMD>InstantStartSession 0.0.0.0 8080<CR><CMD>TermExec cmd=\'ngrok --log=stdout tcp 8080 | grep -o "tcp://.*.ngrok.io:[0-9]*"\'<CR>',
  { table.unpack(noremap_silent), desc = 'Starts A Live Server In ToggleTerm Terminal' }
)
keymap(
  'n',
  '<leader>md',
  '<CMD>cd %:p:h<CR>',
  { table.unpack(noremap_silent), desc = 'Set Current Directory To The Current File' }
)

-- Spotify
vim.api.nvim_set_keymap('n', '<leader>sn', '<Plug>(SpotifySkip)', { silent = true }) -- Skip the current track
vim.api.nvim_set_keymap('n', '<leader>sp', '<Plug>(SpotifyPause)', { silent = true }) -- Pause/Resume the current track
vim.api.nvim_set_keymap('n', '<leader>ss', '<Plug>(SpotifySave)', { silent = true }) -- Add the current track to your library
vim.api.nvim_set_keymap('n', '<leader>so', ':Spotify<CR>', { silent = true }) -- Open Spotify Search window
vim.api.nvim_set_keymap('n', '<leader>sb', '<Plug>(SpotifyPrev)', { silent = true }) -- Go back to the previous track
vim.api.nvim_set_keymap('n', '<leader>sh', '<Plug>(SpotifyShuffle)', { silent = true }) -- Toggles shuffle mode

-- Lsp
keymap('n', '<leader>e', vim.diagnostic.open_float)
keymap('n', '<leader>lf', '<CMD>lua vim.lsp.buf.format()<CR>')
keymap('n', '<leader>lr', '<CMD>LspRestart<CR>', { silent = true })
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<leader>q', vim.diagnostic.setloclist)
keymap('n', 'ga', '<CMD>Lspsaga code_action<CR>', { table.unpack(noremap_silent), desc = 'Lsp Code Action' })
keymap('n', 'gr', '<CMD>Lspsaga rename<CR>', { table.unpack(noremap_silent), desc = 'Lsp Rename' })
keymap('n', 'gp', '<CMD>Lspsaga peek_definition<CR>', { table.unpack(noremap_silent), desc = 'Lsp Rename' })
keymap('n', 'gf', '<CMD>Lspsaga peek_definition<CR>', { table.unpack(noremap_silent), desc = 'Lsp Rename' })
keymap('n', 'gs', function()
  require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'Toggle Signature' })
keymap('n', '<leader>gd', vim.lsp.buf.definition, { silent = true, noremap = true, desc = 'Jump To Definition' })
keymap('n', 'gh', '<CMD>Lspsaga lsp_finder<CR>')
keymap({ 'n', 'v' }, '<leader>ca', '<CMD>Lspsaga code_action<CR>')
keymap('n', 'gr', '<CMD>Lspsaga rename<CR>')
keymap('n', 'gr', '<CMD>Lspsaga rename ++project<CR>')
keymap('n', 'gp', '<CMD>Lspsaga peek_definition<CR>')
keymap('n', 'gd', '<CMD>Lspsaga goto_definition<CR>')
keymap('n', 'gt', '<CMD>Lspsaga peek_type_definition<CR>')
keymap('n', 'gt', '<CMD>Lspsaga goto_type_definition<CR>')
keymap('n', '<leader>sl', '<CMD>Lspsaga show_line_diagnostics<CR>')
keymap('n', '<leader>sb', '<CMD>Lspsaga show_buf_diagnostics<CR>')
keymap('n', '<leader>sw', '<CMD>Lspsaga show_workspace_diagnostics<CR>')
keymap('n', '<leader>sc', '<CMD>Lspsaga show_cursor_diagnostics<CR>')
keymap('n', '[e', '<CMD>Lspsaga diagnostic_jump_prev<CR>')
keymap('n', ']e', '<CMD>Lspsaga diagnostic_jump_next<CR>')
keymap('n', '[E', function()
  require('lspsaga.diagnostic'):goto_prev { severity = vim.diagnostic.severity.ERROR }
end)
keymap('n', ']E', function()
  require('lspsaga.diagnostic'):goto_next { severity = vim.diagnostic.severity.ERROR }
end)
keymap('n', '<leader>go', '<CMD>Lspsaga outline<CR>')
keymap('n', 'K', '<CMD>Lspsaga hover_doc<CR>')

-- Misc
keymap('n', '<leader>d0', 'd^', { table.unpack(noremap_silent), desc = 'Delete Until First Character' })
keymap('n', '<leader>c0', 'c^', { table.unpack(noremap_silent), desc = 'Cut Until First Character' })
keymap(
  'n',
  '<leader>mk',
  '<CMD>call cursor(0, len(getline("."))/2)<CR>',
  { table.unpack(noremap_silent), desc = 'Cut Until First Character' }
)

keymap('i', '˙', '<C-<Left>>')
keymap('i', '∆', '<C-<Down>>')
keymap('i', '˚', '<C-<Up>>')
keymap('i', '¬', '<C-<Right>>')

keymap('n', '˙', '<C-<Left>>')
keymap('n', '∆', '<C-<Down>>')
keymap('n', '˚', '<C-<Up>>')
keymap('n', '¬', '<C-<Right>>')

-- Trailblazer
keymap(
  'n',
  '<leader>em',
  '<CMD>TrailBlazerNewTrailMark<CR>',
  { table.unpack(noremap_silent), desc = 'Trailblazer make mark' }
)
keymap(
  'n',
  '<leader>ek',
  '<CMD>TrailBlazerPeekMovePreviousUp<CR>',
  { table.unpack(noremap_silent), desc = 'Trailblazer Previous Mark' }
)
keymap(
  'n',
  '<leader>ej',
  '<CMD>TrailBlazerPeekMoveNextDown<CR>',
  { table.unpack(noremap_silent), desc = 'Trailblazer Down Mark' }
)
keymap(
  'n',
  '<leader>ed',
  '<CMD>TrailBlazerDeleteAllTrailMarks<CR>',
  { table.unpack(noremap_silent), desc = 'Trailblazer Delete All Marks' }
)

-- LSP
keymap('n', '<leader>e', vim.diagnostic.open_float)
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<leader>q', vim.diagnostic.setloclist)
keymap('n', '<leader>ga', '<CMD>Lspsaga code_action<CR>', { table.unpack(noremap_silent), desc = 'Lsp Code Action' })
keymap('n', '<leader>gr', '<CMD>Lspsaga rename<CR>', { table.unpack(noremap_silent), desc = 'Lsp Rename' })
keymap('n', '<leader>gp', '<CMD>Lspsaga peek_definition<CR>', { table.unpack(noremap_silent), desc = 'Lsp Rename' })
keymap('n', '<leader>gs', function()
  require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'Toggle Signature' })
keymap('n', '<leader>gd', vim.lsp.buf.definition, { silent = true, noremap = true, desc = 'Jump To Definition' })

-- Buffers
keymap('n', '<Leader>bn', '<CMD>BufferNext<CR>', { table.unpack(noremap_silent), desc = 'Go To Next Buffer' })
keymap('n', '<Leader>bb', '<CMD>BufferPrevious<CR>', { table.unpack(noremap_silent), desc = 'Go To Previous Buffer' })
keymap('n', '<Leader>br', '<CMD>BufferRestore<CR>', { table.unpack(noremap_silent), desc = 'Restore Last Buffer' })
keymap('n', '<Leader>bc', '<CMD>BufferClose<CR>', { table.unpack(noremap_silent), desc = 'Close Current Buffer' })
keymap(
  'n',
  '<Leader>bv',
  '<CMD>BufferCloseAllButVisible<CR>',
  { table.unpack(noremap_silent), desc = 'Close All Buffers Except Visible' }
)

keymap('n', '<leader>b1', '<CMD>BufferGoto 1<CR>', { table.unpack(noremap_silent), desc = 'Go To Buffer 1' })
keymap('n', '<leader>b2', '<CMD>BufferGoto 2<CR>', { table.unpack(noremap_silent), desc = 'Go To Buffer 2' })
keymap('n', '<leader>b3', '<CMD>BufferGoto 3<CR>', { table.unpack(noremap_silent), desc = 'Go To Buffer 3' })
keymap('n', '<leader>b4', '<CMD>BufferGoto 4<CR>', { table.unpack(noremap_silent), desc = 'Go To Buffer 4' })
keymap('n', '<leader>b5', '<CMD>BufferGoto 5<CR>', { table.unpack(noremap_silent), desc = 'Go To Buffer 5' })
keymap('n', '<leader>b8', '<CMD>BufferGoto 8<CR>', { table.unpack(noremap_silent), desc = 'Go To Buffer 8' })
keymap('n', '<leader>b6', '<CMD>BufferGoto 6<CR>', { table.unpack(noremap_silent), desc = 'Go To Buffer 6' })
keymap('n', '<leader>b7', '<CMD>BufferGoto 7<CR>', { table.unpack(noremap_silent), desc = 'Go To Buffer 7' })
