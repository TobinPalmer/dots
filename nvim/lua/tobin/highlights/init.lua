local function update_hl(group, tbl)
  local old_hl = vim.api.nvim_get_hl_by_name(group, true)
  local new_hl = vim.tbl_extend('force', old_hl, tbl)
  vim.api.nvim_set_hl(0, group, new_hl)
end

local italic = {
  'Keyword',
  '@keyword.function',
  '@keyword.return',
  'Type',
  '@type.builtin',
}

local bold = {}

local italic_and_bold = {
  'Special',
  'StorageClass',
  'Structure',
  'Statement',
}

for _, group in ipairs(italic) do
  update_hl(group, { italic = true })
end

for _, group in ipairs(bold) do
  update_hl(group, { bold = true })
end

for _, group in ipairs(italic_and_bold) do
  update_hl(group, { italic = true, bold = true })
end
