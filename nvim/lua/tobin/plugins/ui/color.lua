local colorsscheme = {
  { name = 'folke/tokyonight.nvim', theme = 'tokyonight', enabled = true },
  { name = 'ellisonleao/gruvbox.nvim', theme = 'gruvbox', enabled = false },
  { name = 'Mofiqul/dracula.nvim', theme = 'dracula', enabled = false },
}

local object = {}

for _, scheme in pairs(colorsscheme) do
  table.insert(object, { scheme.name, cond = scheme.enabled })
  if scheme.enabled then
    vim.api.nvim_create_autocmd('UIEnter', {
      callback = function()
        vim.cmd('colorscheme ' .. scheme.theme)
      end,
    })
  end
end

return object
