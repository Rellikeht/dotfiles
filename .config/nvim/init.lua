-- {{{  helpers
vim.cmd("source ~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
NVIM_DIR = vim.call("stdpath", "config")
local lua_dir = NVIM_DIR .. "/lua"
local vim_dir = "~/.vim"
local plug_dir = "plug-handlers/"

-- }}}

-- TODO other manager
vim.call("plug#begin", NVIM_DIR .. "/plugins")
vim.cmd("source " .. vim_dir .. "/common-plugins.vim")

-- {{{ dependencies

Plug("nvim-lua/plenary.nvim")

-- }}}

-- {{{ look enchancing

Plug(
  "nvim-treesitter/nvim-treesitter",
  {["do"] = ":silent! TSUpdate"}
)
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
Plug("dcampos/cmp-snippy")
Plug("honza/vim-snippets")

-- TODO more cmps ?
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-nvim-lsp-signature-help")
Plug("hrsh7th/cmp-nvim-lua")

Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-omni")
Plug("hrsh7th/cmp-path")
-- TODO C async path

Plug("hrsh7th/cmp-cmdline")
Plug("rasulomaroff/cmp-bufname")
Plug("micangl/cmp-vimtex")

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

Plug("hedyhli/outline.nvim")

Plug("puremourning/vimspector")
Plug("jgdavey/tslime.vim")
Plug("vim-test/vim-test")

Plug("p00f/clangd_extensions.nvim")

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
