return {
  'stevearc/overseer.nvim',
  config = function()
    local overseer = require 'overseer'
    overseer.setup {
      templates = { 'tobin.typescript' },
    }

    vim.api.nvim_create_user_command('Grep', function(params)
      local args = vim.fn.expandcmd(params.args)
      -- Insert args at the '$*' in the grepprg
      local cmd, num_subs = vim.o.grepprg:gsub('%$%*', args)
      if num_subs == 0 then
        cmd = cmd .. ' ' .. args
      end
      local task = overseer.new_task {
        cmd = cmd,
        components = {
          {
            'on_output_quickfix',
            errorformat = vim.o.grepformat,
            -- open = not params.bang,
            open_height = 8,
            items_only = true,
          },
          { 'on_complete_dispose', timeout = 30 },
          'default',
        },
      }
      task:start()
    end, { nargs = '*', bang = true, complete = 'file' })

    vim.api.nvim_create_user_command('WatchRun', function()
      local overseer = require 'overseer'
      overseer.run_template({ name = 'tsc' }, function(task)
        if task then
          task:add_component { 'restart_on_save', paths = { vim.fn.expand '%:p' } }
          local main_win = vim.api.nvim_get_current_win()
          overseer.run_action(task, 'open vsplit')
          vim.api.nvim_set_current_win(main_win)
        else
          vim.notify('WatchRun not supported for filetype ' .. vim.bo.filetype, vim.log.levels.ERROR)
        end
      end)
    end, {})
  end,
}
