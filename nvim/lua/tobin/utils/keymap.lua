local M = {}

--- Table based API for setting keybindings
---@param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
---@param base? table A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
  -- iterate over the first keys for each mode
  base = base or {}
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base
        if type(options) == 'table' then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend('force', keymap_opts, options)
          keymap_opts[1] = nil
        end
        -- if not cmd or keymap_opts.name then -- if which-key mapping, queue it
        --   if not M.which_key_queue then
        --     M.which_key_queue = {}
        --   end
        --   if not M.which_key_queue[mode] then
        --     M.which_key_queue[mode] = {}
        --   end
        --   M.which_key_queue[mode][keymap] = keymap_opts
        -- else -- if not which-key mapping, set it
        --   vim.keymap.set(mode, keymap, cmd, keymap_opts)
        -- end

        -- for k, v in pairs(keymap_opts) do
        --   print(cmd, k, v)
        -- end

        vim.keymap.set(tostring(mode), tostring(keymap), tostring(cmd), keymap_opts)
      end
    end
  end
end

return M
