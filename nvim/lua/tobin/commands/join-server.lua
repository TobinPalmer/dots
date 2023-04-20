_G.join_tcp = function(args)
  vim.api.nvim_command('InstantJoinSession' .. string.gsub(args, 'tcp://', ''):gsub(':', ' '))
end

vim.api.nvim_command 'command! -nargs=1 JoinTCP lua join_tcp(<f-args>)'
