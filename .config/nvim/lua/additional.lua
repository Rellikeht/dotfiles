-- editorconfig {{{
-- Proper editorconfig handling
vim.g.editorconfig = false
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufReadPre" }, {
    pattern = { "*" },
    ---@diagnostic disable-next-line: unused-local
    callback = function(ev)
      vim.b.editorconfig = vim.g.editorconfig
    end,
  }
)

vim.keymap.set(
  { "n", "v" }, "<Leader>qeg",
  ":let g:editorconfig=!g:editorconfig<CR>"
)
vim.keymap.set(
  { "n", "v" }, "<Leader>qeb",
  ":let b:editorconfig=!b:editorconfig<CR>"
)
-- Totally amateur
vim.keymap.set(
  { "n", "v" }, "<Leader>qer", "<Leader>qeb<Leader>qeb"
)

-- }}}

-- settings {{{

vim.api.nvim_create_autocmd(
  { "BufEnter" }, {
    pattern = { "*/.config/nvim*/*.lua" },
    ---@diagnostic disable-next-line: unused-local
    callback = function(ev)
      vim.cmd("setlocal keywordprg=':help'")
    end,
  }
)

-- Because neovim (treesitter) somehow get this fucked
vim.api.nvim_create_autocmd(
  { "BufRead" }, {
    pattern = { "*/doc/*.txt" },
    callback = function()
      vim.bo.filetype = "help"
      vim.bo.syntax = "help"
    end,
  }
)

-- }}}

-- keymaps {{{

vim.api.nvim_set_keymap(
  "t", "<C-_>", "<C-\\>", { noremap = true }
)
vim.api.nvim_set_keymap(
  "t", "<C-\\>n", "<C-\\><C-n>", { noremap = true }
)
vim.api.nvim_set_keymap(
  "t", "<C-\\>o", "<C-\\><C-o>", { noremap = true }
)

for key_in, key_out in pairs(
  {
    ["h"] = "<C-w>h",
    ["j"] = "<C-w>j",
    ["k"] = "<C-w>k",
    ["l"] = "<C-w>l",
    ["gt"] = "gt",
    ["gT"] = "gT",
  }
) do
  vim.api.nvim_set_keymap(
    "t", "<C-\\>" .. key_in,
    "<C-\\><C-n>" .. key_out .. "<Esc>", { noremap = true }
  )
end

-- }}}

-- colors {{{

vim.cmd.colorscheme("elflord")
vim.cmd.highlight("CursorLine", "guibg=#404040")

-- TODO C why is this reset after vim config
vim.cmd(
  [[
hi DiffAdd
            \ ctermbg=DarkGreen guibg=#0d5826
            \ ctermfg=NONE guifg=NONE
hi DiffText
            \ ctermbg=Gray guibg=#566670
            \ ctermfg=NONE guifg=NONE
hi DiffChange
            \ ctermbg=DarkBlue guibg=#0f1a7f
            \ ctermfg=NONE guifg=NONE
hi DiffDelete
            \ ctermbg=DarkRed guibg=#800620
            \ ctermfg=NONE guifg=NONE

hi Added ctermfg=10 guifg=LimeGreen
hi Removed ctermfg=9 guifg=Red
]]
)

vim.g.java_ignore_markdown = true

-- }}}

if vim.g.neovide then -- {{{

  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_cursor_hack = false
  vim.g.neovide_scale_factor = 0.95

  -- for uniform experience
  for _, mode in pairs({ "n", "t", "o", "v", "i" }) do
    vim.api.nvim_set_keymap(
      mode, "<C-/>", "<C-_>", { noremap = true }
    )
  end

end --  }}}
