return {
  'TobinPalmer/pastify.nvim',
  event = 'InsertEnter',
  config = function()
    -- Function to load and parse the .env file
    ---@return table<string, string>
    local function loadEnvFile(path)
      local file = assert(io.open(path, 'r'))

      local variables = {}
      for line in file:lines() do
        local key, value = line:match '^([^=]+)=(.*)$'
        if key and value then
          variables[key] = value
        end
      end

      file:close()
      return variables
    end
    local envPath
    if vim.fn.has 'macunix' == 0 then
      envPath = '/home/tobin/.config/.env'
    else
      envPath = '/Users/tobin/.config/.env'
    end
    local envVariables = loadEnvFile(envPath)

    local api_key = envVariables['PASTE_IMG_API_KEY']

    require('pastify').setup {
      opts = {
        apikey = api_key,
        save = 'local',
        absolute_path = false,
      },
      ft = {
        markdown = '<img src="$IMG$" alt="">',
      },
    }
    vim.keymap.set('n', '<leader>pi', '<CMD>Pastify<CR>')
  end,
}
