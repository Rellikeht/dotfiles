local lspconfig = require('lspconfig')
local cmp = require('cmp')
local autopairs = require('nvim-autopairs').setup {}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

cmp.setup({
	enabled = function()
		local context = require('cmp.config.context')
		local mode = vim.api.nvim_get_mode().mode
		if mode == 'c' then
			return true
		else
			return not context.in_syntax_group('Comment')
				and not context.in_syntax_group('String')
		end
	end,

	mapping = cmp.mapping.preset.insert({
		['<C-e>'] = cmp.mapping.abort(),

		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),

		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(8),
		['<C-b>'] = cmp.mapping.scroll_docs(-8),
	}),

	sources = {
		{ name = 'nvim_lsp' },
		--{ name = 'buffer' },
	}
})

-- If you want insert `(` after select function or method item
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)

function ssetup(server)
	lspconfig[server].setup({
		on_attach = lsp_attach,
		capabilities = capabilities,
	})
end

local servers = {
	'lua_ls',
	'pylsp',
	'gopls',
	'ccls',
	'ocamllsp',
	'zls',
	'nim_langserver',
}

for _, s in ipairs(servers) do ssetup(s) end
