require("functions")

vim.cmd("source ~/.vimrc")
vim.cmd.colorscheme("elflord")

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

-- Proper editorconfig handling
vim.g.editorconfig = false
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufReadPre"}, {
    pattern = {"*"},
    ---@diagnostic disable-next-line: unused-local
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
-- Totally unprofessional
vim.keymap.set(
  {"n", "v"}, "<Leader>qer", "<Leader>qeb<Leader>qeb"
)
