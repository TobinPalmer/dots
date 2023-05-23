local function toggle_preview()
  local ft = vim.bo.filetype
  if ft == 'markdown' then
    require('peek').open()
  elseif ft == 'tex' then
    require('knap').toggle_autopreviewing()
  else
    vim.notify('Preview not available', vim.log.levels.WARN)
  end
end

vim.api.nvim_create_user_command('TogglePreview', toggle_preview, {})
