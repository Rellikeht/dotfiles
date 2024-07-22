-- {{{  helpers
vim.cmd("source ~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
local nvim_dir = vim.call("stdpath", "config")
local lua_dir = nvim_dir .. "/lua"
local vim_dir = "~/.vim"
local plug_dir = "plug-handlers/"

-- }}}

vim.call("plug#begin", nvim_dir .. "/plugins")
vim.cmd("source " .. vim_dir .. "/common-plugins.vim")

-- {{{ dependencies

Plug("nvim-lua/plenary.nvim")

-- }}}

-- {{{ look enchancing

Plug("nvim-treesitter/nvim-treesitter", {["do"] = ":TSUpdate"})
Plug("norcalli/nvim-colorizer.lua")

-- might not work
-- Plug("3rd/image.nvim") -- TODO B

-- }}}

-- {{{ motion enchancing

-- Plug("easymotion/vim-easymotion")
Plug("ThePrimeagen/harpoon", {["branch"] = "harpoon2"})

Plug("nvim-treesitter/nvim-treesitter-textobjects")

-- }}}

-- {{{ completion

Plug("neovim/nvim-lspconfig")
Plug("mfussenegger/nvim-jdtls")

Plug("dcampos/nvim-snippy")

-- TODO more cmps ?
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-nvim-lsp-signature-help") -- rly?
Plug("hrsh7th/cmp-nvim-lua")

-- }}}

-- {{{ other coding help

Plug("Vimjas/vint")
Plug("nvim-orgmode/orgmode") -- TODO B

Plug("mfussenegger/nvim-lint")
Plug("windwp/nvim-autopairs")
Plug("nvim-treesitter/nvim-treesitter-refactor")

-- THIS IS ALL SHIT, IT CAN'T FIND ANYTHING IN SYSTEM
-- DEPENDENCIES CAN'T BE FOUND, WHY THIS HAS TO BE SO FUCKED
-- Plug("vhyrro/luarocks.nvim")
-- Plug("benlubas/molten-nvim") -- TODO B

Plug("puremourning/vimspector")
Plug("vim-test/vim-test")

-- }}}

-- {{{ nice to have

Plug("jubnzv/mdeval.nvim")
Plug("AckslD/nvim-FeMaco.lua")

-- }}}

vim.call("plug#end")

-- {{{ loading rest of config

local confMods = {
  "motion",
  "cmp",
  "colors",
  "treesitter",
  "lspconfig",
  "coding",
  "other",
}

local confVimMods = {"motion", "testing"}

for _, i in ipairs(confMods) do require(plug_dir .. i) end
for _, i in ipairs(confVimMods) do
  vim.cmd("source " .. lua_dir .. "/" .. plug_dir .. i .. ".vim")
end
require("additional")

-- }}}
