require('nvim_comment').setup {
  marker_padding = true,
  comment_empty = true,
  comment_empty_trim_whitespace = true,
  create_mappings = true,
  comment_chunk_text_object = 'ic',
}

vim.keymap.set({ 'n', 'v' }, '<C-\\>', ':CommentToggle<CR>', { noremap = true, silent = true })
