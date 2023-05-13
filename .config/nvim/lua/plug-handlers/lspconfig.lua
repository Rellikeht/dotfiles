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
	'pylsp', -- Not tested well
	'gopls', -- Not tested well
	'clangd',

	--'scheme_langserver',
	'julials', -- Untested
	'ocamllsp', -- Untested
	'zls',

	-- on freebsd nimlsp can't even start
	-- this leaves nimsuggest instances behind
	-- at least on simple projects with only .nim files
	'nim_langserver',

	'rust_analyzer', -- Untested
	'tsserver', -- untested

	--'bashls', -- TODO C
	--'vimls', -- TODO C
	--'opencl_ls', -- TODO C

	--'awk_ls', -- TODO D
	--'erlangls', --TODO D
	--'yamlls', -- TODO D
}

for _, s in ipairs(servers) do ssetup(s) end

-- TODO 
-- nimlangserver has it's own problems, maybe they can be
-- adressed by copying solutions from vscode extension
--lspconfig.nim_langserver.setup({
--	single_file_support = true,
--	on_attach = lsp_attach,
--	capabilities = Capabilities,
--	nim_timeout = 1000,
--})
