local function toggle_preview()
  local ft = vim.bo.filetype
  if ft == 'markdown' then
    vim.cmd [[ MarkdownPreview ]]
  elseif ft == 'html' then
    vim.cmd [[ BrowserOpen ]]
  elseif ft == 'tex' then
    local _, success = pcall(require, 'vimtex')
    if not success then
      vim.notify('vimtex not loaded', vim.log.levels.WARN)
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
