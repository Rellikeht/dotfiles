-- {{{
vim.cmd.source("~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
VIM_DIR = "~/.vim"

-- }}}

vim.fn["plug#begin"](vim.fn.stdpath("data") .. "/plugins")
vim.cmd.source(VIM_DIR .. "/plugins.vim")

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

Plug("ellisonleao/glow.nvim", {["for"] = "markdown"})
Plug("jakewvincent/mkdnflow.nvim")

Plug("zah/nim.vim", {["for"] = "nim"})
Plug("ocaml/vim-ocaml", {["for"] = "ocaml"})
Plug("bfrg/vim-cpp-modern", {["for"] = "cpp"})
Plug("elzr/vim-json", {["for"] = "json"})
Plug("elixir-editors/vim-elixir", {["for"] = "elixir"})
Plug "tpope/vim-jdaddy"

-- }}}

vim.fn["plug#end"]()

require("additional")
pcall(require, "local")
