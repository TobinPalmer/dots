local function trim_filename(path)
    local filename = path:match(".+/(.+)$")
    return filename or path
end

local function close_non_visible_buffers()
    local deleted_buffers = {}

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_winnr = vim.fn.bufwinnr(buf)
        if buf_winnr == -1 and not vim.api.nvim_buf_get_name(buf):match("^term") then
            local buf_name = vim.api.nvim_buf_get_name(buf)
            table.insert(deleted_buffers, trim_filename(buf_name))
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end

    if #deleted_buffers > 0 then
        local deleted_buffer_names = table.concat(deleted_buffers, "\n")
        vim.notify("Deleted:\n" .. deleted_buffer_names:gsub("%s+", ""))
    end
end

vim.api.nvim_create_user_command("Wipeout", close_non_visible_buffers, {})

-- vim.cmd [[  function! Wipeout()
--     " list of *all* buffer numbers
--    let l:buffers = range(1, bufnr('$'))
--     " what tab page are we in?
--     let l:currentTab = tabpagenr()
--     try
--       " go through all tab pages
--       let l:tab = 0
--       while l:tab < tabpagenr('$')
--         let l:tab += 1
--         " go through all windows
--         let l:win = 0
--         while l:win < winnr('$')
--           let l:win += 1
--           " whatever buffer is in this window in this tab, remove it from
--           " l:buffers list
--           let l:thisbuf = winbufnr(l:win)
--           call echo(l:buffers, index(l:buffers, l:thisbuf))
--           call remove(l:buffers, index(l:buffers, l:thisbuf))
--         endwhile
--       endwhile
--       " if there are any buffers left, delete them
--       if len(l:buffers)
--         execute 'echo' join(l:buffers)
--         execute 'bwipeout' join(l:buffers)
--       endif
--     finally
--       " go back to our original tab page
--       execute 'tabnext' l:currentTab
--     endtry
--   endfunction
--   ]]
