-- Easymotion, telescope, harpoon

-- TODO
-- <Leader>f{char} to move to {char}
keymap("<Leader>f", "<Plug>(easymotion-bd-f)")
nkeymap("<Leader>f", "<Plug>(easymotion-overwin-f)")

-- s{char}{char} to move to {char}{char}
nkeymap("s", "<Plug>(easymotion-overwin-f2)")

-- Move to line
keymap("<Leader>l", "<Plug>(easymotion-bd-jk)")
nkeymap("<Leader>l", "<Plug>(easymotion-overwin-line)")

-- Move to word
keymap("<Leader>w", "<Plug>(easymotion-bd-w)")
nkeymap("<Leader>w", "<Plug>(easymotion-overwin-w)")
