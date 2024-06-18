vim.cmd.colorscheme("elflord")

-- Proper editorconfig handling
vim.g.editorconfig = false
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufReadPre"}, {
    pattern = {"*"},
    ---@diagnostic disable-next-line: unused-local
    callback = function(ev)
      vim.b.editorconfig = vim.g.editorconfig
    end,
  }
)
vim.keymap.set(
  {"n", "v"}, "<Leader>qeg",
  ":let g:editorconfig=!g:editorconfig<CR>"
)
vim.keymap.set(
  {"n", "v"}, "<Leader>qeb",
  ":let b:editorconfig=!b:editorconfig<CR>"
)
-- Totally unprofessional
vim.keymap.set(
  {"n", "v"}, "<Leader>qer", "<Leader>qeb<Leader>qeb"
)

vim.cmd.highlight("CursorLine", "guibg=#525252")
