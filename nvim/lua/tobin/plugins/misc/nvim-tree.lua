local dependencies = {}
if vim.g.opts.use_icons then
  dependencies = { 'nvim-tree/nvim-web-devicons' }
end

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = dependencies,
  cmd = { 'NvimTreeToggle' },
  keys = {
    { '<leader>pv', '<CMD>NvimTreeToggle<CR>', desc = 'Open Nvim-Tree' },
  },
  opts = function()
    local icons = require 'tobin.icons'
    local function tab_win_closed(winnr)
      local api = require 'nvim-tree.api'
      local tabnr = vim.api.nvim_win_get_tabpage(winnr)
      local bufnr = vim.api.nvim_win_get_buf(winnr)
      local buf_info = vim.fn.getbufinfo(bufnr)[1]
      local tab_wins = vim.tbl_filter(function(w)
        return w ~= winnr
      end, vim.api.nvim_tabpage_list_wins(tabnr))
      local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
      if buf_info.name:match '.*NvimTree_%d*$' then -- close buffer was nvim tree
        -- Close all nvim tree on :q
        if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
          api.tree.close()
        end
      else -- else closed buffer was normal buffer
        if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
          local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
          if last_buf_info.name:match '.*NvimTree_%d*$' then -- and that buffer is nvim tree
            vim.schedule(function()
              if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
                vim.cmd 'quit' -- then close all of vim
              else -- else there are more tabs open
                vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
              end
            end)
          end
        end
      end
    end

    vim.api.nvim_create_autocmd('WinClosed', {
      callback = function()
        local winnr = tonumber(vim.fn.expand '<amatch>')
        vim.schedule_wrap(tab_win_closed(winnr))
      end,
      nested = true,
    })

    local function on_attach(bufnr)
      local api = require 'nvim-tree.api'
      local lib = require 'nvim-tree.lib'
      local view = require 'nvim-tree.view'

      --- Nvim tree opts
      --- @param desc string
      local opts = function(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      local mark_move_j = function()
        api.marks.toggle()
        vim.cmd 'norm j'
      end
      local mark_move_k = function()
        api.marks.toggle()
        vim.cmd 'norm k'
      end

      -- marked files operation
      local mark_trash = function()
        local marks = api.marks.list()
        if #marks == 0 then
          table.insert(marks, api.tree.get_node_under_cursor())
        end
        vim.ui.input({ prompt = string.format('Trash %s files? [y/n] ', #marks) }, function(input)
          if input == 'y' then
            for _, node in ipairs(marks) do
              api.fs.trash(node)
            end
            api.marks.clear()
            api.tree.reload()
          end
        end)
      end
      local mark_remove = function()
        local marks = api.marks.list()
        if #marks == 0 then
          table.insert(marks, api.tree.get_node_under_cursor())
        end
        vim.ui.input({ prompt = string.format('Remove/Delete %s files? [y/n] ', #marks) }, function(input)
          if input == 'y' then
            for _, node in ipairs(marks) do
              api.fs.remove(node)
            end
            api.marks.clear()
            api.tree.reload()
          end
        end)
      end

      local mark_copy = function()
        local marks = api.marks.list()
        if #marks == 0 then
          table.insert(marks, api.tree.get_node_under_cursor())
        end
        for _, node in pairs(marks) do
          api.fs.copy.node(node)
        end
        api.marks.clear()
        api.tree.reload()
      end

      local mark_cut = function()
        local marks = api.marks.list()
        if #marks == 0 then
          table.insert(marks, api.tree.get_node_under_cursor())
        end
        for _, node in pairs(marks) do
          api.fs.cut(node)
        end
        api.marks.clear()
        api.tree.reload()
      end

      --- @param file table
      api.events.subscribe(api.events.Event.FileCreated, function(file)
        vim.cmd('edit ' .. file.fname)
      end)

      local function edit_or_open()
        local action = 'edit'
        local node = lib.get_node_at_cursor()

        if node == nil then
          return
        end
        if node.link_to and not node.nodes then
          require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
          if vim.g.opts.nvim_tree.close_on_select then
            view.close()
          end
        elseif node.nodes ~= nil then
          lib.expand_or_collapse(node)
        else
          require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
          if vim.g.opts.nvim_tree.close_on_select then
            view.close()
          end
        end
      end

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', '<bs>', api.node.navigate.parent_close, opts 'close directory')
      vim.keymap.set('n', '<cr>', api.node.open.edit, opts 'open')
      vim.keymap.set('n', '.', api.node.run.cmd, opts 'run command')
      vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts 'up')
      vim.keymap.set('n', 'a', api.fs.create, opts 'create')
      vim.keymap.set('n', 'c', api.fs.copy.node, opts 'copy')
      vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts 'prev git')
      vim.keymap.set('n', ']c', api.node.navigate.git.next, opts 'next git')
      vim.keymap.set('n', 'd', api.fs.trash, opts 'trash')
      vim.keymap.set('n', 'r', api.tree.expand_all, opts 'expand all')
      vim.keymap.set('n', 'r', api.fs.rename_basename, opts 'rename: basename')
      vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts 'next diagnostic')
      vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts 'prev diagnostic')
      vim.keymap.set('n', 'f', api.live_filter.clear, opts 'clean filter')
      vim.keymap.set('n', 'f', api.live_filter.start, opts 'filter')
      vim.keymap.set('n', 'g?', api.tree.toggle_help, opts 'help')
      vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts 'copy absolute path')
      vim.keymap.set('n', 'h', api.tree.toggle_hidden_filter, opts 'toggle dotfiles')
      vim.keymap.set('n', 'i', api.tree.toggle_gitignore_filter, opts 'toggle git ignore')
      vim.keymap.set('n', 'm', api.marks.toggle, opts 'toggle bookmark')
      vim.keymap.set('n', 'o', api.node.open.edit, opts 'open')
      vim.keymap.set('n', 'o', api.node.open.no_window_picker, opts 'open: no window picker')
      vim.keymap.set('n', 'p', api.fs.paste, opts 'paste')
      vim.keymap.set('n', 'q', api.tree.close, opts 'close')
      vim.keymap.set('n', 'r', api.fs.rename, opts 'rename')
      vim.keymap.set('n', 's', api.tree.search_node, opts 'search')
      vim.keymap.set('n', 'u', api.tree.toggle_custom_filter, opts 'toggle hidden')
      vim.keymap.set('n', 'x', api.fs.cut, opts 'cut')
      vim.keymap.set('n', 'y', api.fs.copy.filename, opts 'copy name')

      vim.keymap.set('n', 'l', edit_or_open, opts 'edit or open')
      vim.keymap.set('n', 'h', api.tree.close, opts 'close')
      vim.keymap.set('n', 'H', api.tree.collapse_all, opts 'collapse all')

      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'close directory')
      vim.keymap.set('n', 'h', api.tree.collapse_all, opts 'collapse')

      vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')
      vim.keymap.set('n', 'J', mark_move_j, opts 'Toggle Bookmark Down')
      vim.keymap.set('n', 'K', mark_move_k, opts 'Toggle Bookmark Up')

      vim.keymap.set('n', 'dd', mark_cut, opts 'Cut File(s)')
      vim.keymap.set('n', 'df', mark_trash, opts 'Trash File(s)')
      vim.keymap.set('n', 'dF', mark_remove, opts 'Remove File(s)')

      vim.keymap.set('n', 'mv', api.marks.bulk.move, opts 'Move Bookmarked')
    end
    local HEIGHT_RATIO = 0.8
    local WIDTH_RATIO = 0.5
    local should_icons_render = vim.g.opts.use_icons
    return {
      notify = {
        threshold = vim.log.levels.INFO,
        absolute_path = false,
      },
      renderer = {
        icons = {
          show = {
            file = should_icons_render,
            folder = should_icons_render,
            git = should_icons_render,
            modified = should_icons_render,
          },
          glyphs = {
            default = icons.documents.File,
            symlink = icons.documents.Symlink,
            modified = icons.documents.Files,
            folder = {
              arrow_closed = icons.ui.ChevronRight,
              arrow_open = icons.ui.ChevronDown,
              default = icons.documents.Folder,
              open = icons.documents.OpenFolder,
              empty = icons.documents.EmptyFolder,
              empty_open = icons.documents.OpenFolder,
              symlink = icons.documents.Symlink,
              symlink_open = icons.documents.Symlink,
            },
          },
        },
      },
      sort_by = 'case_sensitive',
      sync_root_with_cwd = true,
      reload_on_bufenter = true,
      on_attach = on_attach,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        float = {
          enable = vim.g.opts.nvim_tree.float,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          if vim.g.opts.nvim_tree.float then
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end
          return 30
        end,
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        debounce_delay = 450,
        icons = {
          error = icons.diagnostics.Error,
          warning = icons.diagnostics.Warning,
          hint = icons.diagnostics.Hint,
          info = icons.diagnostics.Question,
        },
      },
    }
  end,
}
