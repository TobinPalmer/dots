if vim.g.opts.use_icons then
  return {
    wk = {
      FzfLua = " ",
      Buffer = " ",
      File = " ",
      Git = " ",
      Help = " ",
      Lsp = " ",
      Spell = "暈 ",
      Tmux = " ",
      Trouble = " ",
      Nvim_Tree = " ",
      Vim = " ",
      Window = "荒 ",
      Search = " ",
      Snippets = " ",
      Tags = " ",
      VSCode = " ",
      Wiki = " ",
      Workspace = " ",
      Copilot = "󰚩 ",
    },
    lspType = {
      Copilot = "󰚩",
      LSP = "",
      luasnip = " ",
      buffer = "",
      path = " ",
    },
    kind = {
      Text = " ",
      Method = " ",
      Function = "ƒ",
      Constructor = "",
      Field = " ",
      Variable = " ",
      Class = " ",
      Interface = " ",
      Module = " ",
      Property = " ",
      Unit = " ",
      Value = " ",
      Enum = " ",
      Keyword = " ",
      Snippet = " ",
      Color = " ",
      File = " ",
      Reference = " ",
      Folder = " ",
      EnumMember = " ",
      Constant = " ",
      Key = "󰌋 ",
      Null = "󰟢 ",
      Struct = " ",
      Event = " ",
      Operator = " ",
      TypeParameter = " ",
      Misc = " ",
    },
    type = {
      Array = " ",
      Number = " ",
      String = " ",
      Boolean = " ",
      Object = " ",
    },
    documents = {
      File = " ",
      Files = " ",
      Folder = " ",
      EmptyFolder = " ",
      Symlink = " ",
      OpenFolder = " ",
    },
    git = {
      Add = " ",
      Mod = " ",
      Remove = " ",
      Ignore = " ",
      Rename = " ",
      Diff = " ",
      Repo = " ",
      Octoface = " ",
    },
    ui = {
      ArrowClosed = "",
      ArrowOpen = "",
      Lock = " ",
      Circle = " ",
      BigCircle = " ",
      BigUnfilledCircle = " ",
      Close = " ",
      NewFile = " ",
      Search = " ",
      Lightbulb = " ",
      Project = " ",
      Dashboard = " ",
      History = " ",
      Comment = " ",
      Bug = " ",
      Code = " ",
      Telescope = " ",
      Gear = " ",
      Package = " ",
      List = " ",
      SignIn = " ",
      SignOut = " ",
      NoteBook = " ",
      Check = " ",
      Fire = " ",
      Note = " ",
      BookMark = " ",
      Pencil = " ",
      ChevronRight = "",
      ChevronLeft = "",
      ChevronDown = "",
      Table = " ",
      Calendar = " ",
      CloudDownload = " ",
    },
    diagnostics = {
      Error = " ",
      Warning = " ",
      Information = " ",
      Question = " ",
      Hint = " ",
    },
    misc = {
      Robot = " ",
      Lightning = "󱐋 ",
      Squirrel = " ",
      Tag = " ",
      Watch = " ",
      Smiley = " ",
      Package = " ",
      CircuitBoard = " ",
    },
  }
else
  return {
    lspType = {
      Copilot = "[COPILOT]",
      LSP = "[LSP]",
      luasnip = "[SNIP]",
      buffer = "[BUF]",
      path = "[PATH]",
    },
    kind = {
      Text = "[TEXT]",
      Method = "[METHOD]",
      Function = "[FUNC]",
      Constructor = "[CONSTRUCTOR]",
      Field = "[FIELD]",
      Variable = "[VAR]",
      Class = "[CLASS]",
      Interface = "[INTERFACE]",
      Module = "[MODULE]",
      Property = "[PROPERTY]",
      Unit = "[UNIT]",
      Value = "[VALUE]",
      Enum = "[ENUM]",
      Keyword = "[KEYWORD]",
      Snippet = "[SNIP]",
      Color = "[COLOR]",
      File = "[FILE]",
      Reference = "[REF]",
      Folder = "[FOLDER]",
      EnumMember = "[ENUM]",
      Constant = "[CONST]",
      Key = "[KEY]",
      Null = "[NULL]",
      Struct = "[STRUCT]",
      Event = "[EVENT]",
      Operator = "[OPERATOR]",
      TypeParameter = "[TYPE]",
      Misc = "[MISC]",
    },
    type = {
      Array = "[ARRAY]",
      Number = "[NUMBER]",
      String = "[STRING]",
      Boolean = "[BOOLEAN]",
      Object = "[OBJECT]",
    },
    documents = {
      File = "[FILE]",
      Files = "[FILES]",
      Folder = "[FOLDER]",
      EmptyFolder = "[EMPTY]",
      Symlink = "[SYMLINK]",
      OpenFolder = "[FOLDER]",
    },
    git = {
      Add = "A",
      Mod = "M",
      Remove = "R",
      Ignore = "[IGNORE]",
      Rename = "[RENAME]",
      Diff = "[DIFF]",
      Repo = "[REPO]",
      Octoface = "[OCTO]",
    },
    ui = {
      ArrowClosed = "> ",
      ArrowOpen = "v ",
      Lock = "[LOCK]",
      Circle = "c ",
      BigCircle = "C ",
      BigUnfilledCircle = "C ",
      Close = "[X]",
      NewFile = "[NEW]",
      Search = "[SEARCH]",
      Lightbulb = "[LIGHT]",
      Project = "[PROJECT]",
      Dashboard = "[DASH]",
      History = "[HIST]",
      Comment = "[COMMENT]",
      Bug = "[BUG]",
      Code = "[CODE]",
      Telescope = "[TELESCOPE]",
      Gear = "[GEAR]",
      Package = "[PKG]",
      List = "L ",
      SignIn = "[SIGN IN]",
      SignOut = "[SIGN OUT]",
      NoteBook = "[NOTEBOOK]",
      Check = "v ",
      Fire = "[FIRE]",
      Note = "[NOTE]",
      BookMark = "[BOOKMARK]",
      Pencil = "M",
      ChevronRight = "> ",
      ChevronLeft = "< ",
      ChevronDown = "v ",
      Table = "[TABLE]",
      Calendar = "[CALENDAR]",
      CloudDownload = "[CLOUD]",
    },
    diagnostics = {
      Error = "X",
      Warning = "W",
      Information = "I",
      Question = "Q",
      Hint = "H",
    },
    misc = {
      Robot = "[ROBOT]",
      Squirrel = "[SQUIRREL]",
      Lightning = "[LIGHTNING]",
      Tag = "[TAG]",
      Watch = "[WATCH]",
      Smiley = "[SMILEY]",
      Package = "[PKG]",
      CircuitBoard = "[CIRCUIT]",
    },
  }
end
