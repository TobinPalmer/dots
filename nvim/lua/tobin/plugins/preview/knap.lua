return {
  'frabjous/knap',
  ft = 'tex',
  event = 'BufReadPre',
  config = function()
    local gknapsettings = {
      texoutputext = 'pdf',
      textopdf = 'pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%',
      textopdfviewerlaunch = 'evince %outputfile%',
      textopdfviewerrefresh = 'kill -HUP %pid%',
    }
    vim.g.knap_settings = gknapsettings
  end,
}
