return {
  'nvim-tree/nvim-tree.lua',
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

      api.events.subscribe(api.events.Event.FileCreated, function(file)
        vim.cmd('edit ' .. file.fname)
      end)

      local function edit_or_open()
        local action = 'edit'
        local node = lib.get_node_at_cursor()

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

      local function vsplit_preview()
        local action = 'vsplit'
        local node = lib.get_node_at_cursor()

        if node == nil then
          return
        end
        if node.link_to and not node.nodes then
          require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
        elseif node.nodes ~= nil then
          lib.expand_or_collapse(node)
        else
          require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
        end

        view.focus()
      end

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', '<c-]>', api.tree.change_root_to_node, opts 'cd')
      vim.keymap.set('n', '<c-e>', api.node.open.replace_tree_buffer, opts 'open: in place')
      vim.keymap.set('n', '<c-k>', api.node.show_info_popup, opts 'info')
      vim.keymap.set('n', '<c-r>', api.fs.rename_sub, opts 'rename: omit filename')
      vim.keymap.set('n', '<c-t>', api.node.open.tab, opts 'open: new tab')
      vim.keymap.set('n', '<c-v>', api.node.open.vertical, opts 'open: vertical split')
      vim.keymap.set('n', '<c-x>', api.node.open.horizontal, opts 'open: horizontal split')
      vim.keymap.set('n', '<bs>', api.node.navigate.parent_close, opts 'close directory')
      vim.keymap.set('n', '<cr>', api.node.open.edit, opts 'open')
      vim.keymap.set('n', '<tab>', api.node.open.preview, opts 'open preview')
      vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts 'next sibling')
      vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts 'previous sibling')
      vim.keymap.set('n', '.', api.node.run.cmd, opts 'run command')
      vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts 'up')
      vim.keymap.set('n', 'a', api.fs.create, opts 'create')
      vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts 'move bookmarked')
      vim.keymap.set('n', 'b', api.tree.toggle_no_buffer_filter, opts 'toggle no buffer')
      vim.keymap.set('n', 'c', api.fs.copy.node, opts 'copy')
      vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts 'prev git')
      vim.keymap.set('n', ']c', api.node.navigate.git.next, opts 'next git')
      vim.keymap.set('n', 'd', api.fs.remove, opts 'delete')
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
      vim.keymap.set('n', 's', api.node.run.system, opts 'run system')
      vim.keymap.set('n', 's', api.tree.search_node, opts 'search')
      vim.keymap.set('n', 'u', api.tree.toggle_custom_filter, opts 'toggle hidden')
      vim.keymap.set('n', 'w', api.tree.collapse_all, opts 'collapse')
      vim.keymap.set('n', 'x', api.fs.cut, opts 'cut')
      vim.keymap.set('n', 'y', api.fs.copy.filename, opts 'copy name')
      vim.keymap.set('n', 'y', api.fs.copy.relative_path, opts 'copy relative path')
      vim.keymap.set('n', '<2-leftmouse>', api.node.open.edit, opts 'open')
      vim.keymap.set('n', '<2-rightmouse>', api.tree.change_root_to_node, opts 'cd')

      vim.keymap.set('n', 'l', edit_or_open, opts 'edit or open')
      vim.keymap.set('n', 'h', api.tree.close, opts 'close')
      vim.keymap.set('n', 'h', api.tree.collapse_all, opts 'collapse all')

      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'close directory')
      vim.keymap.set('n', 'h', api.tree.collapse_all, opts 'collapse')
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
