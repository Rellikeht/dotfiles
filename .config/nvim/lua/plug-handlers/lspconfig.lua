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

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local servers = {
	'lua_ls',
	'pylsp',
	'gopls', -- Not tested well
	'clangd',
	'ocamllsp',

	'julials',
	'zls',

    -- TODO A:

    --'nimlsp',
	-- On freebsd can't even start

	-- This leaves nimsuggest instances running after closing editor
	-- At least on simple projects with only .nim files
	--'nim_langserver',
    -- For now it is added manually later

    -- add if it stops eating so much memory
    --'hls',

    -- TODO B:
    --'rnix-lsp',
    -- or
    --'nixd',

    --'racket_langserver',
    -- or
	--'scheme_langserver',

    --'sqls',
    -- or
    --'sqlls',

    -- Somehow add tcl lsp if it works
    -- https://github.com/Dufgui/lsp-jtcl

    -- TODO C:

	--'rust_analyzer', -- Untested
	--'tsserver', -- Untested

    -- TCL ???
    -- https://github.com/soartech/soar-language-server

	--'bashls', -- hard to get working
	--'vimls', -- probably not really needed
	--'opencl_ls',
	--'awk_ls', -- ???

    -- TODO D:

    --'java_language_server',
    -- or
    --'jdtls', -- Probably too much work

    --'metals', --scala
    --'clojure_lsp',
	--'erlangls',
	--'yamlls',
    --'asm-lsp',
    --'emmet_ls',
    --'gdscript',
    --'fortls',

    --'perlls',
    -- or
    --'perlpls',

    --'vhdl_ls', -- ???

    --'verible',
    -- or
    --'veridian',
}

for _, s in ipairs(servers) do ssetup(s) end

-- nimlangserver has it's own problems, maybe they can be
-- adressed by copying solutions from vscode extension
lspconfig.nim_langserver.setup({
	single_file_support = true,
	on_attach = lsp_attach,
	capabilities = Capabilities,

--	settings = {
--		nim = {
--			--projectMapping = {
--			--	{
--			--		projectPath = "",
--			--		fileregex = "*.nim"
--			--	}
--			--},
--			--timeout = 2000,
--			--autoCheckFile = true,
--
--		}
--	},
})
