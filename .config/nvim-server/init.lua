-- {{{
vim.cmd("source ~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
NVIM_DIR = vim.call("stdpath", "config")
local vim_dir = "~/.vim"
local plug_dir = "plug-handlers/"

-- }}}

require(plug_dir .. "preplug")
vim.call("plug#begin", NVIM_DIR .. "/plugins")
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

Plug("ellisonleao/glow.nvim")
Plug("jakewvincent/mkdnflow.nvim")

Plug("zah/nim.vim", { ["for"] = "nim" })
Plug("ocaml/vim-ocaml", { ["for"] = "ocaml" })
Plug("bfrg/vim-cpp-modern", { ["for"] = "cpp" })
Plug("elzr/vim-json", { ["for"] = "json" })
Plug "tpope/vim-jdaddy"

-- }}}

vim.call("plug#end")

-- {{{

local modconfigs = { -- {{{
  "motion",
  "cmp",
  "formats",
} -- }}}

for _, i in ipairs(modconfigs) do require(plug_dir .. i) end
require("additional")
pcall(require, "local")

-- }}}
