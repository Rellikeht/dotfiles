-- {{{  helpers
vim.cmd.source("~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
NVIM_DIR = vim.fn.stdpath("config")
local lua_dir = NVIM_DIR .. "/lua"
local vim_dir = "~/.vim"

-- }}}

vim.fn["plug#begin"](vim.fn.stdpath("data"))
vim.cmd.source(vim_dir .. "/common-plugins.vim")

-- {{{ dependencies

Plug("nvim-lua/plenary.nvim")

-- }}}

-- {{{ look enchancing

Plug(
  "nvim-treesitter/nvim-treesitter",
  {["do"] = ":silent! TSUpdate"}
)
Plug("norcalli/nvim-colorizer.lua")

-- }}}

-- {{{ motion enchancing

Plug("nvim-treesitter/nvim-treesitter-textobjects")
Plug("RRethy/nvim-treesitter-endwise")

-- }}}

-- {{{ completion

Plug("neovim/nvim-lspconfig")
Plug("mfussenegger/nvim-jdtls")
Plug("ray-x/lsp_signature.nvim")

Plug("dcampos/nvim-snippy")
Plug("dcampos/cmp-snippy")
Plug("honza/vim-snippets")
Plug("ckunte/typst-snippets-vim")

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
Plug("nvim-orgmode/orgmode") -- TODO C

Plug("mfussenegger/nvim-lint")
Plug("windwp/nvim-autopairs")
Plug("nvim-treesitter/nvim-treesitter-refactor")

Plug("hedyhli/outline.nvim")

-- Needs python compiled in and nvim doesn't have it sometimes ???
-- Plug("puremourning/vimspector")

Plug("jgdavey/tslime.vim") -- needed for testing plugins below
Plug("vim-test/vim-test")
Plug("nvim-neotest/neotest")

Plug("p00f/clangd_extensions.nvim")

-- }}}

-- {{{ nice to have

Plug("jubnzv/mdeval.nvim")
Plug("AckslD/nvim-FeMaco.lua")

Plug("jakewvincent/mkdnflow.nvim")
-- or https://github.com/ixru/nvim-markdown
-- or https://github.com/tadmccorkle/markdown.nvim
-- there is definitely too much plugins available

Plug("ellisonleao/glow.nvim")

-- }}}

-- {{{ TODO C

-- diff browser
-- Plug("sindrets/diffview.nvim")

-- search and replace panel
-- Plug("nvim-pack/nvim-spectre")

-- advanced quickfix/location list
-- + pretty lsp stuff
-- Plug("folke/trouble.nvim")

-- alternative debugging tooling
Plug("mfussenegger/nvim-dap")
Plug("rcarriga/nvim-dap-ui")
Plug("rcarriga/cmp-dap")
Plug("LiadOz/nvim-dap-repl-highlights")

-- and some adapters
-- Plug("mfussenegger/nvim-dap-python")
-- Plug("leoluz/nvim-dap-go")
-- Plug("SGauvin/ctest-telescope.nvim")

-- typst preview
-- https://github.com/chomosuke/typst-preview.nvim
-- https://github.com/Enter-tainer/typst-preview
-- https://github.com/niuiic/typst-preview.nvim
-- again fuck, this is too much

-- }}}

vim.fn["plug#end"]()

require("additional")
pcall(require, "local")
