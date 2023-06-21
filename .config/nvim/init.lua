require('functions')

-- This line makes pacman-installed global Arch Linux vim packages work.
vim.cmd('silent! source /usr/share/nvim/archlinux.vim')

local Plug = vim.fn['plug#']
local nvim_dir = vim.call('stdpath', 'config')
local vim_dir = '~/.vim'
local plug_dir = 'plug-handlers/'

vim.call('plug#begin', nvim_dir..'/plugins')
vim.cmd('source '..vim_dir..'/common-plugins.vim')

-- Dependencies
Plug('nvim-lua/plenary.nvim')

-- Motion
Plug('easymotion/vim-easymotion') -- TODO A
Plug('ThePrimeagen/harpoon') -- TODO A
Plug('nvim-telescope/telescope.nvim', {branch = '0.1.x'}) -- TODO A

-- Look
Plug('nvim-treesitter/nvim-treesitter', {['do'] = 'TSUpdate'})
Plug('norcalli/nvim-colorizer.lua') -- TODO B
Plug('folke/zen-mode.nvim') -- TODO C
-- TODO B TODO plugin :)

-- Specialized
--Plug('kmonad/kmonad-vim')
Plug('mattn/emmet-vim') -- TODO C
-- TODO select
--Plug('vlime/vlime') -- TODO C
--Plug('jpalardy/vim-slime') -- TODO C

-- Completion
--Plug('jayli/vim-easycomplete')
-- Try if ↓ won't work well enough
Plug('neovim/nvim-lspconfig')
Plug('dcampos/nvim-snippy') -- TODO A (let this not interrupt normal work)
Plug('windwp/nvim-autopairs') -- TODO B
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp') -- TODO C
Plug('hrsh7th/cmp-nvim-lua')

--Plug('rmagatti/auto-session') -- TODO B

vim.call('plug#end')

local modconfigs = {
	'motion',
	'cmp',
	'lspconfig',
	'colors',
	'rest',
}

for _, i in ipairs(modconfigs) do
	require(plug_dir..i)
end

vim.cmd('source ~/.vimrc')
vim.opt.termguicolors = true
vim.cmd.colorscheme('elflord')
