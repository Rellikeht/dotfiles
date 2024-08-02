-- {{{
vim.cmd("source ~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
local nvim_dir = vim.call("stdpath", "config")
local vim_dir = "~/.vim"
local plug_dir = "plug-handlers/"

-- }}}

vim.call("plug#begin", nvim_dir .. "/plugins")
vim.cmd("source " .. vim_dir .. "/common-plugins.vim")

-- {{{

Plug("nvim-lua/plenary.nvim")
Plug("norcalli/nvim-colorizer.lua")
Plug("windwp/nvim-autopairs")

Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lua")

Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-omni")
Plug("hrsh7th/cmp-path")

Plug("hrsh7th/cmp-cmdline")
Plug("rasulomaroff/cmp-bufname")

-- }}}

vim.call("plug#end")

-- {{{

local modconfigs = { -- {{{
  "motion",
  "cmp",
} -- }}}

for _, i in ipairs(modconfigs) do require(plug_dir .. i) end
require("additional")

-- }}}
