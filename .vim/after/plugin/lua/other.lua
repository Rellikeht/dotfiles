-- TODO C What a mess
-- NVIM_LINT {{{
local nvim_lint = require("lint")

nvim_lint.linters_by_ft = { -- {{{
  markdown = {"vale"},
  python = {"pylint", "flake8", "mypy", "ruff"},
  shell = {"dash", "shellcheck"},
  bash = {"dash", "shellcheck"},
  zsh = {"zsh"},
  vim = {"vint"},
  nix = {"nix"},
  ansible = {"ansible-lint"},
  yaml = {"yamllint"},
  -- javascript = {"eslint_d"},
  -- typescript = {"eslint_d"},
}

-- }}}

-- autocmd {{{

vim.g["buflint"] = false
vim.api.nvim_create_autocmd(
  {"FileType"}, {
    pattern = "*",
    callback = function() vim.b["buflint"] = vim.g["buflint"] end,
  }
)

local nvim_lint_augroup = "nvim_lint_augroup"

local function toggleNvimLInt()
  if vim.b["buflint"] then
    vim.api.nvim_del_augroup_by_name(nvim_lint_augroup)
  else
    local lint_augroup = vim.api.nvim_create_augroup(
      nvim_lint_augroup, {clear = true}
    )
    vim.api.nvim_create_autocmd(
      {"BufWritePost", "InsertLeave"}, {
        group = lint_augroup,
        buffer = 0,
        callback = function() nvim_lint.try_lint() end,
      }
    )
  end

  -- This doesn't work properly :(
  nvim_lint.try_lint()
  vim.b["buflint"] = not vim.b["buflint"]
end

-- }}}

-- maps {{{

vim.keymap.set(
  "n", "<leader>dc", function() nvim_lint.try_lint() end,
  {desc = "Trigger linting for current file"}
)

vim.keymap.set(
  "n", "<leader>dC", toggleNvimLInt,
  {desc = "Toggle linting on events for current file"}
)

-- }}}

-- configurations {{{

-- eslint_d is shit
-- eslint too
-- local eslint_d = require "lint.linters.eslint_d"
-- eslint_d.args = vim.tbl_extend(
--                   "force", {
--     "--config",
--     -- function() return vim.fn.getcwd() .. "/eslint.config.js" end,
--     function()
--       return vim.fn.getenv("HOME") .. "/eslint.config.js"
--     end,
--   }, eslint_d.args
--                 )

-- TODO
-- Set pylint to work in virtualenv
-- nvim_lint.linters.pylint.cmd = "python"
-- nvim_lint.linters.pylint.args = {"-m", "pylint", "-f", "json"}

-- }}}

-- }}}

-- formatting {{{

-- turn off formatting enabled in lspconfig
-- when lsp exits
vim.api.nvim_create_autocmd(
  {"LspDetach"}, {
    buffer = 0,
    callback = function()
      local ftype = vim.api.nvim_get_option_value(
        "filetype", {scope = "local"}
      )
      if Lfiles[ftype] ~= nil then
        vim.cmd(
          [[
          let b:buffmt = b:lspfmt
          let b:lspfmt = 0
          unmap <Leader>dqf
          augroup! lspformat
        ]]
        )
      end
    end,
  }
)

vim.api.nvim_create_autocmd(
  {"BufWritePost"}, {
    buffer = 0,
    callback = function()
      vim.cmd.normal("zv")
      -- autocmd BufWritePost *.go normal! zv
    end,
  }
)

-- }}}

-- others {{{

vim.cmd("let g:zig_fmt_autosave = 0")

-- fugitive colors fix
vim.cmd(
  [[
autocmd FileType fugitive
      \ hi clear diffAdded
      \ | hi clear diffRemoved
      \ | hi def link diffAdded Added
      \ | hi def link diffRemoved Removed
]]
)

-- }}}
