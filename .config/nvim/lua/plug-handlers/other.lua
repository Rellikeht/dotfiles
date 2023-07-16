-- colorizer, zen-mode

-- vim-slime
vim.g.slime_target = "tmux"
vim.g.slime_paste_file = vim.call("tempname")
vim.g.slime_default_config = {socket_name="default", target_pane="{last}"}
vim.g.slime_dont_ask_default = 1

vim.g.slime_no_mappings = 1
keymap("gsr", "<Plug>SlimeRegionSend")
keymap("gsp", "<Plug>SlimeParagraphSend")
keymap("gsc", "<Plug>SlimeConfig")
-- TODO cells
