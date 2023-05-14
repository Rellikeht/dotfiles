require('functions')

-- This line makes pacman-installed global Arch Linux vim packages work.
vim.cmd('silent! source /usr/share/nvim/archlinux.vim')

local Plug = vim.fn['plug#']
local nvim_dir = vim.call('stdpath', 'config')
local vim_dir = '~/.vim'
local plug_dir = 'plug-handlers/'

vim.call('plug#begin', nvim_dir..'/plugins')
vim.cmd('source '..vim_dir..'/common-plugins.vim')

Plug('norcalli/nvim-colorizer.lua') -- TODO B
--Plug('kmonad/kmonad-vim')
Plug('mattn/emmet-vim')
Plug('vlime/vlime') -- TODO C

Plug('easymotion/vim-easymotion') -- TODO A
Plug('nvim-lua/plenary.nvim') -- Dependency
Plug('ThePrimeagen/harpoon') -- TODO A
Plug('nvim-treesitter/nvim-treesitter', {on = 'TSUpdate'}) -- TODO B
Plug('nvim-telescope/telescope.nvim', {branch = '0.1.x'}) -- TODO A
Plug('folke/zen-mode.nvim') -- TODO C

Plug('dcampos/nvim-snippy') -- TODO A (let this not interrupt normal work)
Plug('neovim/nvim-lspconfig')
Plug('windwp/nvim-autopairs') -- TODO B
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp') -- TODO C
Plug('hrsh7th/cmp-nvim-lua')

vim.call('plug#end')

modconfigs = {
	'motion',
	'cmp',
	'lspconfig',
	'treesitter',
	'rest',
}

for _, i in ipairs(modconfigs) do
	require(plug_dir..i)
end

--Plug 'neoclide/coc.nvim', { 'branch': 'release' }
--vim.cmd('silent! source ~/.config/nvim/plugs/coc.vim')

vim.cmd('source ~/.vimrc')
vim.opt.termguicolors = true
vim.cmd.colorscheme('elflord')
