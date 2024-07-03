-- {{{  helpers
vim.cmd("source ~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
local nvim_dir = vim.call("stdpath", "config")
local vim_dir = "~/.vim"
local plug_dir = "plug-handlers/"

-- }}}

vim.call("plug#begin", nvim_dir .. "/plugins")
vim.cmd("source " .. vim_dir .. "/common-plugins.vim")

-- {{{ dependencies

Plug("nvim-lua/plenary.nvim")

-- }}}

-- {{{ look enchancing

Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("norcalli/nvim-colorizer.lua") -- TODO C
-- Plug('folke/tokyonight.nvim') -- elflord is good enough

-- might not work
-- Plug("3rd/image.nvim") -- TODO B

-- }}}

-- {{{ motion enchancing

Plug("easymotion/vim-easymotion")                       -- TODO A
Plug("ThePrimeagen/harpoon", { ["branch"] = "harpoon2" }) -- TODO A
-- Plug("nvim-telescope/telescope.nvim") -- TODO B
-- Plug('nvim-telescope/telescope.nvim', {branch = '0.1.x'}) -- TODO B

-- TODO C test that
Plug("nvim-treesitter/nvim-treesitter-textobjects")

-- }}}

-- {{{ completion

Plug("neovim/nvim-lspconfig")
Plug("mfussenegger/nvim-jdtls")

-- This is probably done:
-- TODO B (let this not interrupt normal work)
Plug("dcampos/nvim-snippy")

-- TODO more cmps ?
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-nvim-lsp-signature-help") -- rly?
Plug("hrsh7th/cmp-nvim-lua")

-- }}}

-- {{{ other coding help

-- Plug('nvim-orgmode/orgmode') -- TODO B

Plug("mfussenegger/nvim-lint")                   -- TODO this is bad
Plug("windwp/nvim-autopairs")                    -- TODO B
Plug("nvim-treesitter/nvim-treesitter-refactor") -- TODO C

-- THIS IS ALL SHIT, IT CAN'T FIND ANYTHING IN SYSTEM
-- DEPENDENCIES CAN'T BE FOUND, WHY THIS HAS TO BE SO FUCKED
-- Plug("vhyrro/luarocks.nvim")
-- Plug("benlubas/molten-nvim") -- TODO B

Plug("puremourning/vimspector") -- TODO C

-- }}}

-- {{{ nice to have

Plug("jubnzv/mdeval.nvim")
Plug("AckslD/nvim-FeMaco.lua")

-- }}}

vim.call("plug#end")

-- {{{ loading rest of config

local modconfigs = {
  "motion",
  "cmp",
  "colors",
  "treesitter",
  "lspconfig",
  "other",
}

for _, i in ipairs(modconfigs) do require(plug_dir .. i) end
require("additional")

-- }}}
