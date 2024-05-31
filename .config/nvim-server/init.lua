require("functions")

vim.cmd("source ~/.vimrc")
vim.cmd.colorscheme("elflord")

local Plug = vim.fn["plug#"]
local nvim_dir = vim.call("stdpath", "config")
local vim_dir = "~/.vim"
local plug_dir = "plug-handlers/"

vim.call("plug#begin", nvim_dir .. "/plugins")
vim.cmd("source " .. vim_dir .. "/common-plugins.vim")

Plug("norcalli/nvim-colorizer.lua")
Plug("easymotion/vim-easymotion")
Plug("windwp/nvim-autopairs")

vim.call("plug#end")

local modconfigs = {
  "motion",
  "other",
}

for _, i in ipairs(modconfigs) do require(plug_dir .. i) end

-- Proper editorconfig handling
vim.g.editorconfig = false
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufReadPre"}, {
    pattern = {"*"},
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
vim.keymap.set(
  {"n", "v"}, "<Leader>qer", "<Leader>qeb<Leader>qeb"
)
