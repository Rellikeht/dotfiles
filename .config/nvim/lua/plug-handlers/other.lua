-- TODO What a mess
-- {{{ helpers
local modes = {"n", "v"}

-- }}}

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
  modes, "gle", ":MdEval<CR>", {silent = true, noremap = true}
)
vim.keymap.set(modes, "glc", ":MdEvalClean<CR>") -- ???

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

vim.keymap.set(modes, "glf", ":FeMaco<CR>", {noremap = true})

-- NVIM-LINT}}}

-- {{{ NVIM_LINT

local nvim_lint = require("lint")

nvim_lint.linters_by_ft = {
  markdown = {"vale"},
  python = {"pylint", "flake8", "mypy", "ruff"},
  shell = {"dash", "shellcheck"},
  bash = {"dash", "shellcheck"},
  zsh = {"zsh"},
  vim = {"vint"},
  nix = {"nix"},
  ansible = {"ansible-lint"},
  yaml = {"yamllint"},
}

-- local lint_augroup = vim.api.nvim_create_augroup(
--                        "lint", {clear = true}
--                      )

-- vim.api.nvim_create_autocmd(
--   {"BufEnter", "BufWritePost", "InsertLeave"}, {
--     group = lint_augroup,
--     callback = function() nvim_lint.try_lint() end
--   }
-- )

vim.keymap.set(
  "n", "<leader>dc", function() nvim_lint.try_lint() end,
  {desc = "Trigger linting for current file"}
)

-- TODO
-- Set pylint to work in virtualenv
-- nvim_lint.linters.pylint.cmd = "python"
-- nvim_lint.linters.pylint.args = {"-m", "pylint", "-f", "json"}

-- }}}

-- {{{ TODO C COLORIZER
-- }}}

-- {{{ TODO D ZEN-MODE ??
-- }}}

-- {{{ neoformat

-- TODO more formatting through language server

vim.cmd("let g:neoformat_enabled_go = []")

vim.api.nvim_create_autocmd(
  "BufWritePre", {
    pattern = {"*.go", "*.jl", "*.zig"},
    command = "lua vim.lsp.buf.format()",
  }
)

-- }}}

-- {{{ others

vim.cmd("let g:zig_fmt_autosave = 0")

-- }}}
