-- vim.api.nvim_create_autocmd({ 'UIEnter' }, {
--   callback = function()
--     vim.cmd [[cd %:p:h]]
--     print(path, 'VIM PATH')
--   end,
-- })

local path = vim.loop.cwd()

vim.api.nvim_create_autocmd({ --[[ 'BufEnter', ]] 'BufWinEnter' }, {
  callback = function()
    -- path = vim.fn.execute 'pwd'
    if path ~= nil then
      vim.loop.chdir(path)
    end
    -- vim.cmd(string.format('cd %s', path))
  end,
})
