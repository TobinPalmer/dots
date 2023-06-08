local function toggle_preview()
  local ft = vim.bo.filetype
  if ft == 'markdown' then
    local peek, success = pcall(require, 'markdown-preview.nvim')
    if not success then
      print 'preview not loaded'
      vim.cmd [[ Lazy load markdown-preview.nvim ]]
      require('peek').open()
      return
    end
    require('peek').open()
  elseif ft == 'tex' then
    local _, success = pcall(require, 'vimtex')
    if not success then
      print 'vimtex not loaded'
      return
    end
    vim.cmd [[ VimtexCompile ]]
  else
    vim.notify('Preview not available', vim.log.levels.WARN)
  end
end

---@param event "BufWinEnter" | "BufWinLeave"
---@param callback function
local function auto(event, callback, ...)
  local args = { ... }

  vim.api.nvim_create_autocmd({ event }, {
    pattern = { '*.tex' },
    callback = function()
      callback(unpack(args))
    end,
  })
end

auto('BufWinEnter', toggle_preview)
auto('BufWinLeave', os.execute, 'pkill Skim')

vim.api.nvim_create_user_command('TogglePreview', toggle_preview, {})
