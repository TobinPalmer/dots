vim.g.mapleader = ' '
if not table.unpack then
  table.unpack = unpack
end

vim.keymap.set('n', '<leader>mls', '<CMD>LiveServerStart<CR>', { desc = 'Start HTML Live Server' })

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('v', '<A-j>', ':m >+1<CR>gv=gv')
vim.keymap.set('v', '<A-k>', ':m <-2<CR>gv=gv')
vim.keymap.set('v', '<A-j>', ':m >+1<CR>gv=gv')
vim.keymap.set('n', '<leader>mh', '<CMD>noh<CR>', { desc = 'Clears Highlighting' })
vim.keymap.set('n', '<leader>mc', '<CMD>e ~/.config/nvim/init.lua<CR><CMD>cd %:p:h<CR>', { desc = 'Edits init.lua' })
vim.keymap.set('n', '<leader>ma', '<CMD>vimgrep "\\%^" **/*<CR>', { desc = 'Renames variable' })
vim.keymap.set('n', '<leader>gr', '<CMD>lua vim.lsp.buf.rename()<CR>', { desc = 'Renames variable' })
vim.keymap.set(
  'n',
  '<leader>ml',
  '<CMD>InstantStartServer 0.0.0.0 8080<CR><CMD>InstantStartSession 0.0.0.0 8080<CR><CMD>TermExec cmd=\'ngrok --log=stdout tcp 8080 | grep -o "tcp://.*.ngrok.io:[0-9]*"\'<CR>',
  { desc = 'Starts A Live Server In ToggleTerm Terminal' }
)
vim.keymap.set('n', '<leader>md', '<CMD>cd %:p:h<CR>', { desc = 'Set Current Directory To The Current File' })
if vim.g.neovide then
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set('n', '<D-s>', ':w<CR>', { desc = 'Cool' })
  vim.keymap.set('v', '<D-c>', '"+y', { desc = 'Cool' })
  vim.keymap.set('n', '<D-v>', '"+P', { desc = 'Cool' })
  vim.keymap.set('v', '<D-v>', '"+P', { desc = 'Cool' })
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli', { desc = 'Cool' })
  vim.keymap.set('i', '<D-h>', '<C-w>h', { desc = 'Cool' })
  vim.keymap.set('n', '<D-j>', '<C-w>j', { desc = 'Cool' })
  vim.keymap.set('i', '<D-l>', '<C-w>l', { desc = 'Cool' })
  vim.keymap.set('i', '<D-k>', '<C-w>k', { desc = 'Cool' })
  vim.keymap.set('i', '<D-h>', '<C-w>h', { desc = 'Cool' })
  vim.keymap.set('i', '<D-j>', '<C-w>j', { desc = 'Cool' })
  vim.keymap.set('i', '<D-l>', '<C-w>l', { desc = 'Cool' })
  vim.keymap.set('i', '<D-k>', '<C-w>k', { desc = 'Cool' })
  vim.keymap.set('n', '<D-v>', '+p<CR>', { desc = 'Cool' })
  vim.keymap.set('t', '<D-v>', '<C-R>+', { desc = 'Cool' })
  vim.keymap.set('v', '<D-v>', '<C-R>+', { desc = 'Cool' })
end

vim.keymap.set('i', '˙', '<C-<Left>>', { desc = 'cool' })
vim.keymap.set('i', '∆', '<C-<Down>>', { desc = 'cool' })
vim.keymap.set('i', '˚', '<C-<Up>>', { desc = 'cool' })
vim.keymap.set('i', '¬', '<C-<Right>>', { desc = 'cool' })
vim.keymap.set('n', '˙', '<C-<Left>>', { desc = 'cool' })
vim.keymap.set('n', '∆', '<C-<Down>>', { desc = 'cool' })
vim.keymap.set('n', '˚', '<C-<Up>>', { desc = 'cool' })
vim.keymap.set('n', '¬', '<C-<Right>>', { desc = 'cool' })
vim.keymap.set('n', 'd0', 'd^', { desc = 'Delete Until First Character' })
vim.keymap.set('n', 'c0', 'c^', { desc = 'Cut Until First Character' })

vim.keymap.set('n', '<leader>mp', '<CMD>TogglePreview<CR>', { desc = 'Starts a live preview of markdown or tex' })
vim.keymap.set('n', '<leader>lr', '<CMD>LspRestart<CR>', { desc = 'Restart Lsp Server' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'd]', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>gd', '<CMD>Lspsaga goto_definition<CR>', { desc = 'Cool' })
vim.keymap.set('n', 'gd', '<CMD>Lspsaga goto_definition<CR>', { desc = 'Cool' })
vim.keymap.set('n', '<Leader>bc', '<CMD>bd<CR>', { desc = 'Close Current Buffer' })
vim.keymap.set('n', 'ci$', 'T$vt$c', { desc = 'Close Current Buffer' })
vim.keymap.set('n', 'ca$', 'F$vf$c', { desc = 'Close Current Buffer' })
vim.keymap.set('n', 'di$', 'T$vt$d', { desc = 'Close Current Buffer' })
vim.keymap.set('n', 'da$', 'F$vf$d', { desc = 'Close Current Buffer' })

vim.cmd [[cabbrev w' w]]
