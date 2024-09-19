-- {{{  helpers
vim.cmd("source ~/.vimrc")
require("functions")

local Plug = vim.fn["plug#"]
NVIM_DIR = vim.call("stdpath", "config")
local lua_dir = NVIM_DIR .. "/lua"
local vim_dir = "~/.vim"
local plug_dir = "plug-handlers/"

-- }}}

-- TODO other manager (lazy?)
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
Plug("nvim-treesitter/nvim-treesitter-textobjects")

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
Plug("nvim-orgmode/orgmode") -- TODO B

Plug("mfussenegger/nvim-lint")
Plug("windwp/nvim-autopairs")
Plug("nvim-treesitter/nvim-treesitter-refactor")

-- THIS IS ALL SHIT, IT CAN'T FIND ANYTHING IN SYSTEM
-- DEPENDENCIES CAN'T BE FOUND, WHY THIS HAS TO BE SO FUCKED
-- Plug("vhyrro/luarocks.nvim")
-- Plug("benlubas/molten-nvim") -- TODO B

Plug("hedyhli/outline.nvim")

Plug("jgdavey/tslime.vim")
Plug("puremourning/vimspector")

Plug("vim-test/vim-test")
Plug("nvim-neotest/neotest")

Plug("p00f/clangd_extensions.nvim")
Plug("ilyachur/cmake4vim")

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

-- advanced ui
-- Plug("nvim-telescope/telescope.nvim")
-- other telescopes will land here too

-- diff browser
-- Plug("sindrets/diffview.nvim")

-- search and replace panel
-- Plug("nvim-pack/nvim-spectre")

-- advanced quickfix/location list
-- + pretty lsp stuff
-- Plug("folke/trouble.nvim")

-- alternative debugging tooling
-- Plug("mfussenegger/nvim-dap")
-- Plug("rcarriga/nvim-dap-ui")
-- Plug("rcarriga/cmp-dap")
-- Plug("LiadOz/nvim-dap-repl-highlights")

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

vim.call("plug#end")

-- {{{ loading rest of config

local confMods = {
  "motion",
  "cmp",
  "look",
  "treesitter",
  "lspconfig",
  "coding",
  "formats",
  -- "images",
  "other",
}

local confVimMods = {
  -- "motion",
  "testing",
}

for _, i in ipairs(confMods) do require(plug_dir .. i) end
for _, i in ipairs(confVimMods) do
  vim.cmd("source " .. lua_dir .. "/" .. plug_dir .. i .. ".vim")
end
require("additional")

if fileReadable(NVIM_DIR .. "/local.lua") then
  loadfile(NVIM_DIR .. "/local.lua")()
end

-- }}}
