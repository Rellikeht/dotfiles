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

-- {{{ MDEVAL

vim.api.nvim_create_autocmd(
  {"BufRead", "BufNewFile"},
  {pattern = "*.md", command = "set syntax=markdown"}
)

require("mdeval").setup(
  {
    -- Don't ask before executing code blocks
    require_confirmation = false,
    -- Change code blocks evaluation options.
    eval_options = {
      -- TODO B more configurations, defaults:
      -- .config/nvim/plugins/mdeval.nvim/lua/defaults.lua
      -- Set custom configuration for C++
      -- cpp = {
      --   command = {"clang++", "-std=c++20", "-O0"},
      --   default_header = [[
      -- #include <iostream>
      -- #include <vector>
      -- using namespace std;
      --   ]]
      -- }
    },
  }
)

vim.keymap.set(
  modes, "<Leader>m+", ":MdEval<CR>",
  {silent = true, noremap = true}
)
vim.keymap.set(modes, "<Leader>m-", ":MdEvalClean<CR>") -- ???

-- }}}

-- {{{ FEMACO

local femacoUtils = require("femaco.utils")
local clip_val = femacoUtils.clip_val
require("femaco").setup(
  {
    -- should prepare a new buffer and return the winid
    -- by default opens a floating window
    -- provide a different callback to change this behaviour
    -- @param opts: the return value from float_opts
    prepare_buffer = function(opts)
      local buf = vim.api.nvim_create_buf(false, false)
      return vim.api.nvim_open_win(buf, true, opts)
    end,

    -- should return options passed to nvim_open_win
    -- @param code_block: data about the code-block with the keys
    --   * range
    --   * lines
    --   * lang
    float_opts = function(code_block)
      return {
        relative = "cursor",
        width = clip_val(
          5, 120, vim.api.nvim_win_get_width(0) - 10
        ), -- TODO how to offset sign column etc?
        height = clip_val(
          20, #code_block.lines,
          vim.api.nvim_win_get_height(0) - 6
        ),
        anchor = "NW",
        row = 0,
        col = 0,
        style = "minimal",
        border = "rounded",
        zindex = 1,
      }
    end,

    -- return filetype to use for a given lang
    -- lang can be nil
    ft_from_lang = function(lang) return lang end,

    -- what to do after opening the float
    post_open_float = function(winnr)
      vim.wo.signcolumn = "no"
    end,

    -- create the path to a temporary file
    create_tmp_filepath = function(filetype)
      return os.tmpname()
    end,

    -- if a newline should always be used, useful for multiline injections
    -- which separators needs to be on separate lines such as markdown, neorg etc
    -- @param base_filetype: The filetype which FeMaco is called from, not the
    -- filetype of the injected language (this is the current buffer so you can
    -- get it from vim.bo.filetyp).
    ensure_newline = function(base_filetype) return false end,

    -- Return true if the indentation should be normalized. Useful when the
    -- injected language inherits indentation from the construction scope (e.g. an
    -- inline multiline sql string). If true, the leading indentation is detected,
    -- stripped, and restored before/after editing.
    --
    -- @param base_filetype: The filetype which FeMaco is called from, not the
    -- filetype of the injected language (this is the current buffer, so you can
    -- get it from vim.bo.filetype).
    normalize_indent = function(base_filetype) return false end,
  }
)

vim.keymap.set(modes, ",me", ":FeMaco<CR>", {noremap = true})

-- }}}

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
