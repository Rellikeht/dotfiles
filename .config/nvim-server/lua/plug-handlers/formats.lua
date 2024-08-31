-- {{{ helpers
local modes = {"n", "v"}

-- }}}

require("mkdnflow").setup( -- {{{
  {
    modules = {
      bib = true,
      buffers = true,
      conceal = true,
      cursor = true,
      folds = true,
      foldtext = true,
      links = true,
      lists = true,
      maps = true,
      paths = true,
      tables = true,
      yaml = false,
      cmp = true,
    },

    -- ??
    wrap = false,

    mappings = {
      MkdnEnter = {{"n", "v"}, "<CR>"},
      MkdnCreateLink = false, -- see MkdnEnter
      MkdnTab = false,
      MkdnSTab = false,
      -- TODO
      -- MkdnNextLink = {"n", "<Tab>"},
      -- MkdnPrevLink = {"n", "<S-Tab>"},
      -- MkdnGoBack = {"n", "<BS>"},
      -- MkdnGoForward = {"n", "<Del>"},
      -- MkdnNewListItemBelowInsert = {"n", "o"},
      -- MkdnNewListItemAboveInsert = {"n", "O"},
      -- MkdnTableNextCell = {"i", "<Tab>"},
      -- MkdnTablePrevCell = {"i", "<S-Tab>"},
      MkdnNextHeading = {"n", "]]"},
      MkdnPrevHeading = {"n", "[["},
      MkdnCreateLinkFromClipboard = {{"n", "v"}, "<leader>ml"}, -- see MkdnEnter
      MkdnFollowLink = false, -- see MkdnEnter
      MkdnDestroyLink = {"n", "<M-CR>"},
      MkdnTagSpan = {"v", "<M-CR>"},
      MkdnMoveSource = {"n", "<Leader>mm"},
      MkdnYankAnchorLink = {"n", "yaa"},
      MkdnYankFileAnchorLink = {"n", "yfa"},
      MkdnIncreaseHeading = {"n", "+"},
      MkdnDecreaseHeading = {"n", "-"},
      MkdnToggleToDo = {{"n", "v"}, "<Leader>mt"},
      MkdnNewListItem = false,
      MkdnExtendList = false,
      MkdnUpdateNumbering = {"n", "<leader>mn"},
      MkdnTableNextRow = false,
      MkdnTablePrevRow = {"i", "<M-CR>"},
      MkdnTableNewRowBelow = {"n", "<leader>mr"},
      MkdnTableNewRowAbove = {"n", "<leader>mR"},
      MkdnTableNewColAfter = {"n", "<leader>mc"},
      MkdnTableNewColBefore = {"n", "<leader>mC"},
      MkdnFoldSection = {"n", "<leader>mf"},
      MkdnUnfoldSection = {"n", "<leader>mF"},
    },
  }
) -- }}}

require("glow").setup( -- {{{
  {
    border = "shadow", -- floating window border config
    style = "dark", -- filled automatically with your current editor background, you can override using glow json style
    pager = false,
    width = 120,
    height = 140,
    width_ratio = 0.9, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
    height_ratio = 0.9,
  }
)

vim.keymap.set(modes, ",mv", ":Glow<CR>", {noremap = true})
vim.keymap.set(
  modes, ",m<Space>v", ":Glow<CR>", {noremap = true}
)
vim.keymap.set(
  modes, ",m=", ":Glow ~/.vim/keys.md<CR>", {noremap = true}
)

-- }}}
