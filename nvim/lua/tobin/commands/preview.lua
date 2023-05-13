local function toggle_preview()
  local ft = vim.bo.filetype
  if ft == 'markdown' then
    require('peek').open()
  elseif ft == 'tex' then
    require('knap').toggle_autopreviewing()
  else
    print('Preview not available for filetype ' .. ft)
  end
end

-- Define a Neovim command that calls the toggle_preview function
vim.api.nvim_create_user_command('TogglePreview', toggle_preview, {})
