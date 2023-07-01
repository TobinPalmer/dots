local colorsscheme = {
  { name = 'folke/tokyonight.nvim', theme = 'tokyonight-night', enabled = false },
  { name = 'rebelot/kanagawa.nvim', theme = 'kanagawa', enabled = false },
  { name = 'ellisonleao/gruvbox.nvim', theme = 'gruvbox', enabled = false },
  { name = 'Mofiqul/dracula.nvim', theme = 'dracula', enabled = false },
  { name = 'catppuccin/nvim', theme = 'catppuccin-mocha', enabled = true },
}

local object = {}

for _, scheme in pairs(colorsscheme) do
  if scheme.enabled == false then
    table.insert(object, { scheme.name, cond = scheme.enabled })
  else
    table.insert(object, {
      scheme.name,
      cond = true,
      lazy = false,
      config = function()
        vim.cmd('colorscheme ' .. scheme.theme)
        require 'tobin.highlights'
      end,
    })
  end
end

return object
