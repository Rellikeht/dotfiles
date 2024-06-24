vim.cmd("source ~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
local nvim_dir = vim.call("stdpath", "config")
local vim_dir = "~/.vim"
local plug_dir = "plug-handlers/"

vim.call("plug#begin", nvim_dir .. "/plugins")
vim.cmd("source " .. vim_dir .. "/common-plugins.vim")

-- DEPENDENCIES

Plug("nvim-lua/plenary.nvim")

-- LOOK

-- Plug('nvim-orgmode/orgmode') -- TODO B
Plug("nvim-treesitter/nvim-treesitter", {["do"] = ":TSUpdate"})
Plug("norcalli/nvim-colorizer.lua") -- TODO C
-- Plug('folke/tokyonight.nvim') -- TODO C

-- TODO C check if it is needed at all
-- Plug('folke/zen-mode.nvim')

-- MOTION

Plug("easymotion/vim-easymotion") -- TODO A
Plug("ThePrimeagen/harpoon", {["branch"] = "harpoon2"}) -- TODO A
-- Plug("nvim-telescope/telescope.nvim") -- TODO A
-- Plug('nvim-telescope/telescope.nvim', {branch = '0.1.x'}) -- TODO A

-- TODO C test that
Plug("nvim-treesitter/nvim-treesitter-textobjects")

-- COMPLETION

-- Plug('jayli/vim-easycomplete')
-- Try if ↓ won't work well enough
Plug("neovim/nvim-lspconfig") -- TODO A this can autocomplete
Plug("mfussenegger/nvim-jdtls") -- :(

-- This is probably done:
-- TODO B (let this not interrupt normal work)
Plug("dcampos/nvim-snippy")

Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-nvim-lua")

-- OTHER CODING HELP

Plug("mfussenegger/nvim-lint") -- TODO this is bad
Plug("windwp/nvim-autopairs") -- TODO B
Plug("nvim-treesitter/nvim-treesitter-refactor") -- TODO C

-- THIS IS ALL SHIT, IT CAN'T FIND ANYTHING IN SYSTEM
-- DEPENDENCIES CAN'T BE FOUND, WHY THIS HAS TO BE SO FUCKED
-- Plug("vhyrro/luarocks.nvim")
-- Plug("3rd/image.nvim") -- TODO B
-- Plug("benlubas/molten-nvim") -- TODO B

-- :(
Plug("puremourning/vimspector") -- TODO B

-- TODO C try
-- Plug('rmagatti/auto-session')

-- NICE TO HAVE

Plug("jubnzv/mdeval.nvim")
Plug("AckslD/nvim-FeMaco.lua")

vim.call("plug#end")

local modconfigs = {
  "motion",
  "cmp",
  "lspconfig",
  "colors",
  "treesitter",
  "other",
}

for _, i in ipairs(modconfigs) do require(plug_dir .. i) end
require("additional")
