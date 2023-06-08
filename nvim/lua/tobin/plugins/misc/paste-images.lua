return {
  'TobinPalmer/paste-image.nvim',
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

    local envPath = '/Users/tobin/.config/.env'
    local envVariables = loadEnvFile(envPath)

    -- Access environment variables
    local api_key = envVariables['PASTE_IMG_API_KEY']

    require('paste-image').setup {
      options = {
        apikey = api_key,
        online = true,
        computer = false,
      },
    }
    vim.keymap.set('n', '<leader>pi', '<CMD>PasteAsLink<CR>')
  end,
}
