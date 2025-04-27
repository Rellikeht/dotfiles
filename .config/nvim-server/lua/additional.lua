vim.cmd.colorscheme("elflord")

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
-- Totally unprofessional
vim.keymap.set(
  { "n", "v" }, "<Leader>qer", "<Leader>qeb<Leader>qeb"
)

vim.cmd.highlight("CursorLine", "guibg=#404040")

vim.api.nvim_create_autocmd(
  { "BufEnter" }, {
    pattern = { "*/.config/nvim*/*.lua" },
    ---@diagnostic disable-next-line: unused-local
    callback = function(ev)
      vim.cmd("setlocal keywordprg=':help'")
    end,
  }
)

vim.g.java_ignore_markdown = true
