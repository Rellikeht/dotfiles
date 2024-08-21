-- {{{ TODO C COLORIZER
nkeymap(
  "<Leader>qct", ":<C-u>ColorizerToggle<CR>", {noremap = true}
)
vkeymap(
  "<Leader>qct", ":<C-u>ColorizerToggle<CR>gv", {noremap = true}
)
keymap("<Leader>qcT", "<Leader>qct<Leader>qct", {noremap = true})

nkeymap(
  "<Leader>qcr", ":<C-u>ColorizerReloadAllBuffers<CR>",
  {noremap = true}
)
vkeymap(
  "<Leader>qcr", ":<C-u>ColorizerReloadAllBuffers<CR>gv",
  {noremap = true}
)

-- }}}

-- {{{ TODO C colors
vim.cmd("hi Todo		guifg=#ffcf2f	guibg=#0e1224	gui=bold")

-- TODO fucking todo can't change it's color
-- easy to use plugin they say
-- vim.api.nvim_set_hl(0, '@text.todo', { link = 'Todo' })
-- vim.api.nvim_command('hi Todo guifg=#ff0000 guibg=#ff0000 gui=bold')
-- }}}
