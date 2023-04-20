local normap = { noremap = true }
local noremap_silent = { noremap = true, silent = true }
vim.g.mapleader = ' '
local keymap = vim.keymap.set

-- Nvim Tree
keymap('n', '<leader>pv', '<CMD>NvimTreeFocus<CR>', { unpack(normap), desc = 'Focus Nvim-Tree' })

-- Splits
keymap('n', '|', '<CMD>FocusSplitLeft<CR>', { unpack(normap), desc = 'Splits Left' })
keymap('n', '-', '<CMD>FocusSplitDown<CR>', { unpack(normap), desc = 'Splits Down' })

-- Copilot
vim.g.copilot_no_tab_map = true

-- Telescope
keymap(
  'n',
  '<leader>fa',
  '<CMD>lua require"telescope.builtin".find_files()<CR>',
  { unpack(normap), desc = 'Telescope Find All Files' }
)
keymap('n', '<leader>ff', '<CMD>Telescope smart_open<CR>', { unpack(normap), desc = 'Telescope Smart Telescope' })
keymap(
  'n',
  '<leader>fg',
  '<CMD>lua require"telescope.builtin".live_grep()<CR>',
  { unpack(normap), desc = 'Telescope Grep Files' }
)
keymap(
  'n',
  '<leader>fr',
  '<CMD>lua require"telescope.builtin".oldfiles()<CR>',
  { unpack(normap), desc = 'Telescope Find Old Files' }
)
keymap('n', '<leader>fp', '<CMD>Telescope possession list<CR>', { unpack(normap), desc = 'List Saved Sessions' })

-- Trouble
keymap('n', '<leader>tt', '<cmd>TroubleToggle<cr>', { unpack(noremap_silent), desc = 'Toggle Trouble' })
keymap(
  'n',
  '<leader>ta',
  '<cmd>TroubleToggle workspace_diagnostics<cr>',
  { unpack(noremap_silent), desc = 'Toggle Trouble Workspace Diagnostics' }
)
keymap(
  'n',
  '<leader>td',
  '<cmd>TroubleToggle document_diagnostics<cr>',
  { unpack(noremap_silent), desc = 'Toggle Trouble Document Diagnostics' }
)
keymap(
  'n',
  '<leader>tq',
  '<cmd>TroubleToggle quickfix<cr>',
  { unpack(noremap_silent), desc = 'Toggle Trouble Quickfix' }
)

keymap(
  'n',
  '<leader>tj',
  "<cmd>require('trouble').next({ skip_groups = true, jump = true });<cr>",
  { unpack(noremap_silent), desc = 'Next Entry (Trouble)' }
)
keymap(
  'n',
  '<leader>tk',
  "require('trouble').previous({ skip_groups = true, jump = true });",
  { unpack(noremap_silent), desc = 'Previous Entry (Trouble)' }
)
keymap(
  'n',
  '<leader>tgg',
  "require('trouble').first({ skip_groups = true, jump = true });",
  { unpack(noremap_silent), desc = 'Top Of Entries (Trouble)' }
)
keymap(
  'n',
  '<leader>tG',
  "require('trouble').last({ skip_groups = true, jump = true });",
  { unpack(noremap_silent), desc = 'Bottom Of Entries (Trouble)' }
)
-- Live Server
keymap('n', '<leader>mls', '<CMD>LiveServerStart<CR>', { unpack(noremap_silent), desc = 'Start HTML Live Server' })

-- Terminal
keymap('n', '<leader>mt', '<CMD>ToggleTerm<CR>', { unpack(noremap_silent), desc = 'Toggle Terminal' })
keymap('t', '<ESC>h', '<C-\\><C-n><C-w>j<CR>', { unpack(noremap_silent), desc = 'Close Terminal' })

-- Line Folding
keymap('n', '<leader>mf', 'za', { unpack(noremap_silent), desc = 'Toggle Fold' })

-- Hop
keymap('n', '<leader>hh', '<CMD>HopWord<CR>', { unpack(noremap_silent), desc = 'Hop Word' })
keymap('n', '<S-CR>', '<CMD>HopWord<CR>', { unpack(noremap_silent), desc = 'Hop Word' })
keymap('n', '<leader>hl', '<CMD>HopWordCurrentLine<CR>', { unpack(noremap_silent), desc = 'Hop Word In Current Line' })
keymap(
  'n',
  '<leader>ha',
  '<CMD>HopAnywhereCurrentLine<CR>',
  { unpack(noremap_silent), desc = 'Hop Word Anywhere In Current Line' }
)
keymap('n', '<leader>hs', '<CMD>HopChar2<CR>', { unpack(noremap_silent), desc = 'Hop Word (2 Characters)' })

-- Misc Settings
keymap('n', '<leader>mh', '<CMD>noh<CR>', { unpack(noremap_silent), desc = 'Clears Highlighting' })
keymap('n', '<leader>mc', '<CMD>e ~/.config/nvim/init.lua<CR>', { unpack(noremap_silent), desc = 'Edits init.lua' })
keymap(
  'n',
  '<leader>ml',
  '<CMD>InstantStartServer 0.0.0.0 8080<CR><CMD>InstantStartSession 0.0.0.0 8080<CR><CMD>TermExec cmd=\'ngrok --log=stdout tcp 8080 | grep -o "tcp://.*.ngrok.io:[0-9]*"\'<CR>',
  { unpack(noremap_silent), desc = 'Starts A Live Server In ToggleTerm Terminal' }
)
keymap(
  'n',
  '<leader>md',
  '<CMD>cd %:p:h<CR>',
  { unpack(noremap_silent), desc = 'Set Current Directory To The Current File' }
)

-- Lsp
keymap('n', '<leader>e', vim.diagnostic.open_float)
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<leader>q', vim.diagnostic.setloclist)
keymap('n', '<leader>ga', '<Cmd>Lspsaga code_action<CR>', { unpack(noremap_silent), desc = 'Lsp Code Action' })
keymap('n', '<leader>gr', '<Cmd>Lspsaga rename<CR>', { unpack(noremap_silent), desc = 'Lsp Rename' })
keymap('n', '<leader>gp', '<Cmd>Lspsaga peek_definition<CR>', { unpack(noremap_silent), desc = 'Lsp Rename' })
keymap('n', '<leader>gs', function()
  require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'Toggle Signature' })
keymap('n', '<leader>gd', vim.lsp.buf.definition, { silent = true, noremap = true, desc = 'Jump To Definition' })
keymap('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>')
keymap({ 'n', 'v' }, '<leader>ca', '<Cmd>Lspsaga code_action<CR>')
keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>')
keymap('n', 'gr', '<Cmd>Lspsaga rename ++project<CR>')
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

-- Misc
keymap('n', '<leader>d0', 'd^', { unpack(noremap_silent), desc = 'Delete Until First Character' })
keymap('n', '<leader>c0', 'c^', { unpack(noremap_silent), desc = 'Cut Until First Character' })
keymap(
  'n',
  '<leader>mk',
  '<Cmd>call cursor(0, len(getline("."))/2)<CR>',
  { unpack(noremap_silent), desc = 'Cut Until First Character' }
)

keymap('i', '˙', '<C-<Left>>')
keymap('i', '∆', '<C-<Down>>')
keymap('i', '˚', '<C-<Up>>')
keymap('i', '¬', '<C-<Right>>')

keymap('n', '˙', '<C-<Left>>')
keymap('n', '∆', '<C-<Down>>')
keymap('n', '˚', '<C-<Up>>')
keymap('n', '¬', '<C-<Right>>')

keymap('n', '<leader>em', '<Cmd>TrailBlazerNewTrailMark<CR>', { unpack(noremap_silent), desc = 'Trailblazer' })
keymap('n', '<leader>ek', '<Cmd>TrailBlazerPeekMovePreviousUp<CR>', { unpack(noremap_silent), desc = 'Trailblazer' })
keymap('n', '<leader>ej', '<Cmd>TrailBlazerPeekMoveNextDown<CR>', { unpack(noremap_silent), desc = 'Trailblazer' })
keymap('n', '<leader>ed', '<Cmd>TrailBlazerDeleteAllTrailMarks<CR>', { unpack(noremap_silent), desc = 'Trailblazer' })

-- LSP
keymap('n', '<leader>e', vim.diagnostic.open_float)
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<leader>q', vim.diagnostic.setloclist)
keymap('n', '<leader>ga', '<CMD>Lspsaga code_action<CR>', { unpack(noremap_silent), desc = 'Lsp Code Action' })
keymap('n', '<leader>gr', '<CMD>Lspsaga rename<CR>', { unpack(noremap_silent), desc = 'Lsp Rename' })
keymap('n', '<leader>gp', '<CMD>Lspsaga peek_definition<CR>', { unpack(noremap_silent), desc = 'Lsp Rename' })
keymap('n', '<leader>gs', function()
  require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'Toggle Signature' })
keymap('n', '<leader>gd', vim.lsp.buf.definition, { silent = true, noremap = true, desc = 'Jump To Definition' })

-- Buffers
keymap('n', '<Leader>bn', '<Cmd>BufferNext<CR>', { unpack(noremap_silent), desc = 'Go To Next Buffer' })
keymap('n', '<Leader>bb', '<Cmd>BufferPrevious<CR>', { unpack(noremap_silent), desc = 'Go To Previous Buffer' })
keymap('n', '<Leader>br', '<Cmd>BufferRestore<CR>', { unpack(noremap_silent), desc = 'Restore Last Buffer' })
keymap('n', '<Leader>bc', '<Cmd>BufferClose<CR>', { unpack(noremap_silent), desc = 'Close Current Buffer' })
keymap(
  'n',
  '<Leader>bv',
  '<Cmd>BufferCloseAllButVisible<CR>',
  { unpack(noremap_silent), desc = 'Close All Buffers Except Visible' }
)

keymap('n', '<leader>b1', '<Cmd>BufferGoto 1<CR>', { unpack(noremap_silent), desc = 'Go To Buffer 1' })
keymap('n', '<leader>b2', '<Cmd>BufferGoto 2<CR>', { unpack(noremap_silent), desc = 'Go To Buffer 2' })
keymap('n', '<leader>b3', '<Cmd>BufferGoto 3<CR>', { unpack(noremap_silent), desc = 'Go To Buffer 3' })
keymap('n', '<leader>b4', '<Cmd>BufferGoto 4<CR>', { unpack(noremap_silent), desc = 'Go To Buffer 4' })
keymap('n', '<leader>b5', '<Cmd>BufferGoto 5<CR>', { unpack(noremap_silent), desc = 'Go To Buffer 5' })
keymap('n', '<leader>b8', '<Cmd>BufferGoto 8<CR>', { unpack(noremap_silent), desc = 'Go To Buffer 8' })
keymap('n', '<leader>b6', '<Cmd>BufferGoto 6<CR>', { unpack(noremap_silent), desc = 'Go To Buffer 6' })
keymap('n', '<leader>b7', '<Cmd>BufferGoto 7<CR>', { unpack(noremap_silent), desc = 'Go To Buffer 7' })
