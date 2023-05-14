return {
  'xuhdev/vim-latex-live-preview',
  -- event = 'BufReadPre',
  ft = 'tex',
  config = function()
    vim.cmd [[ ]]
  end,
}
