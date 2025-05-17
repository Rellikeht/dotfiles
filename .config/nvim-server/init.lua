-- {{{
vim.cmd("source ~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
local vim_dir = "~/.vim"

-- }}}

vim.fn["plug#begin"](vim.fn.stdpath("data"))
vim.cmd.source(vim_dir .. "/plugins.vim")

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

Plug("zah/nim.vim", {["for"] = "nim"})
Plug("ocaml/vim-ocaml", {["for"] = "ocaml"})
Plug("bfrg/vim-cpp-modern", {["for"] = "cpp"})
Plug("elzr/vim-json", {["for"] = "json"})
Plug "tpope/vim-jdaddy"

-- }}}

vim.fn["plug#end"]()

require("additional")
pcall(require, "local")
