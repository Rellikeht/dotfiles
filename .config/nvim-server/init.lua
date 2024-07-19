vim.cmd("source ~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
local nvim_dir = vim.call("stdpath", "config")
local vim_dir = "~/.vim"
local plug_dir = "plug-handlers/"

vim.call("plug#begin", nvim_dir .. "/plugins")
vim.cmd("source " .. vim_dir .. "/common-plugins.vim")

Plug("norcalli/nvim-colorizer.lua")
-- Plug("easymotion/vim-easymotion")
Plug("windwp/nvim-autopairs")
Plug("ThePrimeagen/harpoon", {["branch"] = "harpoon2"})

vim.call("plug#end")

local modconfigs = {"motion"}

for _, i in ipairs(modconfigs) do require(plug_dir .. i) end
require("additional")
