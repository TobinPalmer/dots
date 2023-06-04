local dependencies = {}
if vim.g.opts.use_icons then
  dependencies = { 'nvim-tree/nvim-web-devicons' }
end

return {
  'ibhagwan/fzf-lua',
  cmd = { 'FzfLua' },
  keys = {
    { '<leader>ff', '<CMD>FzfLua files<CR>', desc = 'Find Files' },
    { '<leader>fg', '<CMD>FzfLua live_grep<CR>', desc = 'Live Grep' },
  },
  dependencies = dependencies,
  config = function()
    local success, _ = pcall(require, 'fzf-lua')
    if not success then
      return
    end
    local actions = require 'fzf-lua.actions'
    local icons = require 'tobin.icons'

    _G.my_action = function(selected, opts)
      if #selected > 1 then
        -- build the quickfix list from the selected items
        require('fzf-lua').actions.file_sel_to_qf(selected, opts)
        -- call the command to open the 'trouble.nvim' interface
        vim.cmd 'TroubleToggle quickfix'
      else
        require('fzf-lua').actions.file_edit(selected, opts)
      end
    end

    -- set as the default action for LSP (or whichever provider you want
    require('fzf-lua').setup {}

    require('fzf-lua').setup {
      global_git_icons = vim.g.opts.use_icons,
      global_file_icons = vim.g.opts.use_icons,
      winopts = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        --[[ hl = {
        }, ]]
        preview = {
          number = true,
          relativenumber = false,
          cursorline = true,
          cursorlineopt = 'both',
          cursorcolumn = false,
          signcolumn = 'no',
          list = false,
          foldenable = false,
          foldmethod = 'manual',
        },
      },
      on_create = function() end,
      keymap = {
        builtin = {
          ['<F1>'] = 'toggle-help',
          ['<F2>'] = 'toggle-fullscreen',
          ['<F3>'] = 'toggle-preview-wrap',
          ['<F4>'] = 'toggle-preview',
          ['<F5>'] = 'toggle-preview-ccw',
          ['<F6>'] = 'toggle-preview-cw',
          ['<S-down>'] = 'preview-page-down',
          ['<S-up>'] = 'preview-page-up',
          ['<S-left>'] = 'preview-page-reset',
        },
        fzf = {
          ['ctrl-z'] = 'abort',
          ['ctrl-u'] = 'unix-line-discard',
          ['ctrl-f'] = 'half-page-down',
          ['ctrl-b'] = 'half-page-up',
          ['ctrl-a'] = 'beginning-of-line',
          ['ctrl-e'] = 'end-of-line',
          ['alt-a'] = 'toggle-all',
          ['f3'] = 'toggle-preview-wrap',
          ['f4'] = 'toggle-preview',
          ['shift-down'] = 'preview-page-down',
          ['shift-up'] = 'preview-page-up',
        },
      },
      actions = {
        files = {
          ['default'] = actions.file_edit_or_qf,
          ['ctrl-s'] = actions.file_split,
          ['ctrl-v'] = actions.file_vsplit,
          ['ctrl-t'] = actions.file_tabedit,
          ['alt-q'] = actions.file_sel_to_qf,
          ['alt-l'] = actions.file_sel_to_ll,
        },
        buffers = {
          ['default'] = actions.buf_edit,
          ['ctrl-s'] = actions.buf_split,
          ['ctrl-v'] = actions.buf_vsplit,
          ['ctrl-t'] = actions.buf_tabedit,
        },
      },
      fzf_opts = {
        ['--ansi'] = '',
        ['--info'] = 'inline',
        ['--height'] = '100%',
        ['--layout'] = 'reverse',
        ['--border'] = 'none',
      },
      fzf_tmux_opts = { ['-p'] = '80%,80%', ['--margin'] = '0,0' },
      --[[ fzf_colors = {
          ["fg"]          = { "fg", "CursorLine" },
          ["bg"]          = { "bg", "Normal" },
          ["hl"]          = { "fg", "Comment" },
          ["fg+"]         = { "fg", "Normal" },
          ["bg+"]         = { "bg", "CursorLine" },
          ["hl+"]         = { "fg", "Statement" },
          ["info"]        = { "fg", "PreProc" },
          ["prompt"]      = { "fg", "Conditional" },
          ["pointer"]     = { "fg", "Exception" },
          ["marker"]      = { "fg", "Keyword" },
          ["spinner"]     = { "fg", "Label" },
          ["header"]      = { "fg", "Comment" },
          ["gutter"]      = { "bg", "Normal" },
      }, ]]
      previewers = {
        cat = {
          cmd = 'cat',
          args = '--number',
        },
        bat = {
          cmd = 'bat',
          args = '--style=numbers,changes --color always',
        },
        head = {
          cmd = 'head',
          args = nil,
        },
        git_diff = {
          cmd_deleted = 'git diff --color HEAD --',
          cmd_modified = 'git diff --color HEAD',
          cmd_untracked = 'git diff --color --no-index /dev/null',
        },
        man = {
          cmd = 'man -c %s | col -bx',
        },
        builtin = {
          treesitter = { enable = true, disable = {} },
          toggle_behavior = 'default',
          extensions = {
            ['png'] = { 'viu', '-b' },
            ['svg'] = { 'chafa' },
            ['jpg'] = { 'ueberzug' },
          },
          ueberzug_scaler = 'cover',
        },
      },
      files = {
        prompt = 'Files❯ ',
        find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/\node_modules/*' -printf '%P\n']],
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts = '--color=never --type f --hidden --follow --exclude .git',
        cwd_prompt = true,
        actions = {
          ['default'] = actions.file_edit,
          ['ctrl-y'] = function(selected)
            print(selected[1])
          end,
        },
      },
      git = {
        files = {
          prompt = 'GitFiles❯ ',
          cmd = 'git ls-files --exclude-standard',
        },
        status = {
          prompt = 'GitStatus❯ ',
          cmd = 'git -c color.status=false status -s',
          file_icons = vim.g.opts.use_icons,
          git_icons = vim.g.opts.use_icons,
          color_icons = vim.g.opts.use_icons,
          previewer = 'git_diff',
          --preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          actions = {
            ['right'] = { actions.git_unstage, actions.resume },
            ['left'] = { actions.git_stage, actions.resume },
            ['ctrl-x'] = { actions.git_reset, actions.resume },
          },
        },
        commits = {
          prompt = 'Commits❯ ',
          cmd = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset'",
          preview = "git show --pretty='%Cred%H%n%Cblue%an <%ae>%n%C(yellow)%cD%n%Cgreen%s' --color {1}",
          --preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          actions = {
            ['default'] = actions.git_checkout,
          },
        },
        bcommits = {
          prompt = 'BCommits❯ ',
          cmd = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset' <file>",
          --preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          actions = {
            ['default'] = actions.git_buf_edit,
            ['ctrl-s'] = actions.git_buf_split,
            ['ctrl-v'] = actions.git_buf_vsplit,
            ['ctrl-t'] = actions.git_buf_tabedit,
          },
        },
        branches = {
          prompt = 'Branches❯ ',
          cmd = 'git branch --all --color',
          preview = 'git log --graph --pretty=oneline --abbrev-commit --color {1}',
          actions = {
            ['default'] = actions.git_switch,
          },
        },
        stash = {
          prompt = 'Stash> ',
          cmd = 'git --no-pager stash list',
          preview = 'git --no-pager stash show --patch --color {1}',
          actions = {
            ['default'] = actions.git_stash_apply,
            ['ctrl-x'] = { actions.git_stash_drop, actions.resume },
          },
          fzf_opts = {
            ['--no-multi'] = '',
            ['--delimiter'] = "'[:]'",
          },
        },
        icons = {
          ['M'] = { icon = 'M', color = 'yellow' },
          ['D'] = { icon = 'D', color = 'red' },
          ['A'] = { icon = 'A', color = 'green' },
          ['R'] = { icon = 'R', color = 'yellow' },
          ['C'] = { icon = 'C', color = 'yellow' },
          ['T'] = { icon = 'T', color = 'magenta' },
          ['?'] = { icon = '?', color = 'magenta' },
        },
      },
      grep = {
        prompt = 'Rg❯ ',
        input_prompt = 'Grep For❯ ',
        grep_opts = '--binary-files=without-match --line-number --recursive --color=auto --perl-regexp',
        rg_opts = '--column --line-number --no-heading --color=always --smart-case --max-columns=4096',
        actions = {
          ['ctrl-g'] = { actions.grep_lgrep },
        },
      },
      args = {
        prompt = 'Args❯ ',
        files_only = true,
        actions = { ['ctrl-x'] = { actions.arg_del, actions.resume } },
      },
      oldfiles = {
        prompt = 'History❯ ',
        cwd_only = false,
      },
      buffers = {
        prompt = 'Buffers❯ ',
        actions = {
          ['ctrl-x'] = { actions.buf_del, actions.resume },
        },
      },
      tabs = {
        prompt = 'Tabs❯ ',
        tab_title = 'Tab',
        tab_marker = '<<',
        actions = {
          ['default'] = actions.buf_switch,
          ['ctrl-x'] = { actions.buf_del, actions.resume },
        },
        fzf_opts = {
          ['--delimiter'] = "'[\\):]'",
          ['--with-nth'] = '2..',
        },
      },
      lines = {
        prompt = 'Lines❯ ',
        fzf_opts = {
          ['--delimiter'] = "'[\\]:]'",
          ['--nth'] = '2..',
          ['--tiebreak'] = 'index',
          ['--tabstop'] = '1',
        },
        actions = {
          ['default'] = actions.buf_edit_or_qf,
          ['alt-q'] = actions.buf_sel_to_qf,
          ['alt-l'] = actions.buf_sel_to_ll,
        },
      },
      blines = {
        prompt = 'BLines❯ ',
        fzf_opts = {
          ['--delimiter'] = "'[\\]:]'",
          ['--with-nth'] = '2..',
          ['--tiebreak'] = 'index',
          ['--tabstop'] = '1',
        },
        actions = {
          ['default'] = actions.buf_edit_or_qf,
          ['alt-q'] = actions.buf_sel_to_qf,
          ['alt-l'] = actions.buf_sel_to_ll,
        },
      },
      tags = {
        prompt = 'Tags❯ ',
        multiprocess = true,
        file_icons = vim.g.opts.use_icons,
        git_icons = vim.g.opts.use_icons,
        color_icons = vim.g.opts.use_icons,
        rg_opts = '--no-heading --color=always --smart-case',
        grep_opts = '--color=auto --perl-regexp',
        actions = {
          ['ctrl-g'] = { actions.grep_lgrep },
        },
      },
      btags = {
        prompt = 'BTags❯ ',
        multiprocess = true,
        file_icons = vim.g.opts.use_icons,
        git_icons = vim.g.opts.use_icons,
        color_icons = vim.g.opts.use_icons,
        rg_opts = '--no-heading --color=always',
        grep_opts = '--color=auto --perl-regexp',
        fzf_opts = {
          ['--delimiter'] = "'[\\]:]'",
          ['--with-nth'] = '2..',
          ['--tiebreak'] = 'index',
        },
      },
      colorschemes = {
        prompt = 'Colorschemes❯ ',
        actions = { ['default'] = actions.colorscheme },
        winopts = { height = 0.55, width = 0.30 },
        post_reset_cb = function() end,
      },
      quickfix = {
        file_icons = vim.g.opts.use_icons,
        git_icons = vim.g.opts.use_icons,
      },
      quickfix_stack = {
        prompt = 'Quickfix Stack> ',
      },
      lsp = {
        actions = { ['default'] = _G.my_action },
        file_icons = true,
        git_icons = false,
        symbols = {
          symbol_icons = {
            File = icons.kind.File,
            Module = icons.kind.Module,
            Namespace = icons.kind.Namespace,
            Package = icons.kind.Package,
            Class = icons.kind.Class,
            Method = icons.kind.Method,
            Property = icons.kind.Property,
            Field = icons.kind.Field,
            Constructor = icons.kind.Constructor,
            Enum = icons.kind.Enum,
            Interface = icons.kind.Interface,
            Function = icons.kind.Function,
            Variable = icons.kind.Variable,
            Constant = icons.kind.Constant,
            String = icons.kind.Text,
            Number = icons.type.Number,
            Boolean = icons.type.Boolean,
            Array = icons.type.Array,
            Object = icons.type.Object,
            Key = icons.kind.Key,
            Null = icons.kind.Null,
            EnumMember = icons.kind.EnumMember,
            Struct = icons.kind.Struct,
            Event = icons.kind.Event,
            Operator = icons.kind.Operator,
            TypeParameter = icons.kind.TypeParameter,
          },
          symbol_hl = function(s)
            return '@' .. s:lower()
          end,
          symbol_fmt = function(s, opts)
            return '[' .. s .. ']'
          end,
          child_prefix = true,
        },
        code_actions = {
          prompt = 'Code Actions> ',
          async_or_timeout = 5000,
          winopts = {
            row = 0.40,
            height = 0.35,
            width = 0.60,
          },
        },
        finder = {
          prompt = 'LSP Finder> ',
          file_icons = vim.g.opts.use_icons,
          color_icons = vim.g.opts.use_icons,
          git_icons = false,
          providers = {
            { 'references', prefix = require('fzf-lua').utils.ansi_codes.blue 'ref ' },
            { 'definitions', prefix = require('fzf-lua').utils.ansi_codes.green 'def ' },
            { 'declarations', prefix = require('fzf-lua').utils.ansi_codes.magenta 'decl' },
            { 'typedefs', prefix = require('fzf-lua').utils.ansi_codes.red 'tdef' },
            { 'implementations', prefix = require('fzf-lua').utils.ansi_codes.green 'impl' },
            { 'incoming_calls', prefix = require('fzf-lua').utils.ansi_codes.cyan 'in  ' },
            { 'outgoing_calls', prefix = require('fzf-lua').utils.ansi_codes.yellow 'out ' },
          },
        },
      },
      diagnostics = {
        prompt = 'Diagnostics❯ ',
        cwd_only = false,
        file_icons = vim.g.opts.use_icons,
        git_icons = false,
        diag_icons = vim.g.opts.use_icons,
      },
      complete_path = {
        actions = { ['default'] = actions.complete_insert },
      },
      complete_file = {
        file_icons = vim.g.opts.use_icons,
        color_icons = vim.g.opts.use_icons,
        git_icons = false,
        actions = { ['default'] = actions.complete_insert },
        winopts = { preview = { hidden = 'hidden' } },
      },
      --
      file_icon_colors = {
        ['sh'] = 'green',
      },
      file_icon_padding = '',
    }
  end,
}
