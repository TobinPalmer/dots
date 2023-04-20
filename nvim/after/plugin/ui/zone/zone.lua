require('zone').setup {
  style = 'treadmill',
  after = 300, -- Idle timeout
  exclude_filetypes = { 'TelescopePrompt', 'NvimTree', 'neo-tree', 'dashboard', 'lazy' },
  -- More options to come later

  treadmill = {
    direction = 'left',
    headache = true,
    tick_time = 30, -- Lower, the faster
    -- Opts for Treadmill style
  },
  epilepsy = {
    stage = 'aura', -- "aura" or "ictal"
    tick_time = 100,
  },
  dvd = {
    tick_time = 100,
  },
}
