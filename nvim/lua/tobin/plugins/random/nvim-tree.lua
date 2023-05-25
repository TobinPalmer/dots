return {
  'nvim-tree/nvim-tree.lua',
  commit = '498e8793bbe73ab5235b3ee8f0aee32f5d01649f',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cmd = { 'NvimTreeToggle' },
  keys = {
    { '<leader>pv', '<cmd>NvimTreeToggle<CR>' },
  },
  opts = function()
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
          view.close()
        elseif node.nodes ~= nil then
          lib.expand_or_collapse(node)
        else
          require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
          view.close()
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
    return {
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
          enable = true,
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
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      ui = {
        confirm = {
          remove = true,
          trash = false,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        debounce_delay = 450,
        icons = {
          error = '',
          warning = '',
          hint = '',
          info = '',
        },
      },
    }
  end,
}
