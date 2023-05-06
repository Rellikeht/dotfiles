require('functions')

-- This line makes pacman-installed global Arch Linux vim packages work.
vim.cmd('silent! source /usr/share/nvim/archlinux.vim')

local Plug = vim.fn['plug#']
local nvim_dir = vim.call('stdpath', 'config')
local vim_dir = '~/.vim'
local plug_dir = 'plug-handlers/'

vim.call('plug#begin', nvim_dir..'/plugins')
vim.cmd('source '..vim_dir..'/common-plugins.vim')

Plug('easymotion/vim-easymotion')
Plug('norcalli/nvim-colorizer.lua')
Plug('kmonad/kmonad-vim')
Plug('numirias/semshi', {on = 'UpdateRemotePlugins'})
Plug('jceb/vim-orgmode')
Plug('vlime/vlime')
Plug('mattn/emmet-vim')
Plug('JuliaEditorSupport/julia-vim')
Plug('nvim-treesitter/nvim-treesitter', {on = 'TSUpdate'})

Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('windwp/nvim-autopairs')

vim.call('plug#end')

modconfigs = {
	--'treesitter',
	'lspconfig',
	'easymotion',
}

for _, i in ipairs(modconfigs) do
	require(plug_dir..i)
end

--Plug 'neoclide/coc.nvim', { 'branch': 'release' }
--vim.cmd('silent! source ~/.config/nvim/plugs/coc.vim')

vim.cmd('source ~/.vimrc')
vim.opt.termguicolors = true
vim.cmd.colorscheme('elflord')
