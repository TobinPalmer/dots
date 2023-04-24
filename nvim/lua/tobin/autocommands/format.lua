function AutoFormat()
  local special = { 'js', 'ts' }

  -- Check if current buffer's file extension is in special
  local function is_special()
    local ext = vim.fn.expand '%:e'
    for _, v in ipairs(special) do
      if v == ext then
        return true
      end
    end
    return false
  end

  if is_special() then
    -- Define the Lua function to be called by the autocmd
    local function mylocalfunction()
      -- do something here
    end

    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      callback = function()
        local ext = vim.fn.expand '%:e'
        if ext == 'ts' or ext == 'js' then
          vim.cmd [[EslintFixAll]]
          vim.cmd [[TypescriptOrganizeImports]]
        end
      end,
    })
    --vim.cmd [[autocmd BufWritePre *.{ts,js} silent! EslintFixAll]]
  else
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
  end
end

-- Call the function on BufReadPost
vim.cmd [[autocmd BufReadPost * lua AutoFormat()]]
