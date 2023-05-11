local lspconfig = require('lspconfig')

local function ssetup(server)
	lspconfig[server].setup({
		preselectSupport = false,
		preselect = false,
		single_file_support = true,
		on_attach = lsp_attach,
		capabilities = Capabilities,
	})
end

local servers = {
	'lua_ls',
	--'bashls',
	'pylsp',

	'gopls',
	'clangd',

	--'scheme_langserver',
	'ocamllsp',

	'zls',
	'nim_langserver',
}

for _, s in ipairs(servers) do ssetup(s) end
