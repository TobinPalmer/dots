local function trim_filename(path)
  local filename = path:match '.+/(.+)$'
  return filename or path
end

local function close_non_visible_buffers()
  local deleted_buffers = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_winnr = vim.fn.bufwinnr(buf)
    if buf_winnr == -1 and not vim.api.nvim_buf_get_name(buf):match '^term' then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      table.insert(deleted_buffers, trim_filename(buf_name))
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  if #deleted_buffers > 0 then
    local deleted_buffer_names = table.concat(deleted_buffers:gsub('%s+', ''), '\n')
    vim.notify('Deleted:\n' .. deleted_buffer_names)
  end
end

vim.api.nvim_create_user_command('Wipeout', close_non_visible_buffers, {})
