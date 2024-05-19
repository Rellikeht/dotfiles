-- Easymotion, telescope, harpoon
-- TODO
-- <Leader>f{char} to move to {char}
keymap("<Leader>f", "<Plug>(easymotion-bd-f)", {noremap = true})
nkeymap(
  "<Leader>f", "<Plug>(easymotion-overwin-f)", {noremap = true}
)

-- s{char}{char} to move to {char}{char}
nkeymap("s", "<Plug>(easymotion-overwin-f2)", {noremap = true})

-- Move to line
keymap("<Leader>l", "<Plug>(easymotion-bd-jk)", {noremap = true})
nkeymap(
  "<Leader>l", "<Plug>(easymotion-overwin-line)",
  {noremap = true}
)

-- Move to word
keymap("<Leader>w", "<Plug>(easymotion-bd-w)", {noremap = true})
nkeymap(
  "<Leader>w", "<Plug>(easymotion-overwin-w)", {noremap = true}
)
