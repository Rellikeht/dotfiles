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

-- Because command line window has some problems
vim.api.nvim_create_autocmd(
  { "BufWinEnter" }, {
    ---@diagnostic disable-next-line: unused-local
    pattern = { "*" },
    command = [[
      if win_gettype() == 'command'
        map <buffer> <CR> <CR>
        nmap <silent> <buffer> <C-l> :<C-u>redraw!<CR>
        vmap <silent> <buffer> <C-l> :<C-u>redraw!\|norm gv<CR>
      endif
    ]],
  }
)

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
