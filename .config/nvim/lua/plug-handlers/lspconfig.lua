local lspconfig = require('lspconfig')

local function ssetup(server)
    local config = lspconfig[server]
    if vim.fn.executable(config.document_config.default_config.cmd[1]) == 0 then
        return
    end

    config.setup({
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
	'bashls',

	'julials',
	'zls',
	'scheme_langserver',
    'hls', -- TODO B memory

	-- 'rust_analyzer',
    'racket_langserver',
    'sqlls',

	'tsserver',

    -- TODO A:

    'nimls',
	-- On freebsd can't even start

	-- This leaves nimsuggest instances running after closing editor
	-- At least on simple projects with only .nim files
	--'nim_langserver',
    -- For now it is added manually later

    -- TODO B:
    --'rnix-lsp',
    -- or
    --'nixd',

    -- TODO C:

    -- Somehow add tcl lsp if it works
    -- https://github.com/Dufgui/lsp-jtcl

    -- TCL ???
    -- https://github.com/soartech/soar-language-server

	--'opencl_ls',

    --'java_language_server',
    -- or
    --'jdtls', -- Probably too much work

    --'metals', --scala
    --'clojure_lsp',
	--'erlangls',
    --'gdscript',

    -- TODO D:

	--'yamlls',
    --'emmet_ls',
    --'fortls',

    --'perlls',
    -- or
    --'perlpls',

    --'vhdl_ls',

    --'verible',
    -- or
    --'veridian',
}

for _, s in ipairs(servers) do
    ssetup(s)
end

-- TODO copying rust-project.json from config dir
-- to current dir to make this shit work

-- No idea if all of that is really needed
lspconfig.rust_analyzer.setup({
    on_attach = lsp_attach,
    preselectSupport = false,
    preselect = false,
    single_file_support = true,
    capabilities = Capabilities,

    settings = {
        ["rust-analyzer"] = {
            -- Doesn't solve the problem
            --standalone = true,
            --workspaceFolders = false,
            --workspace = {
            --    workspaceFolders = false,
            --},

            completion = {
                contextSupport = true,
            },

            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },

            cargo = {
                buildScripts = {
                    enable = true,
                },
            },

            procMacro = {
                enable = true
            },

        }
    }
})

-- nimlangserver has it's own problems, maybe they can be
-- adressed by copying solutions from vscode extension
--lspconfig.nim_langserver.setup({

--	single_file_support = true,
--	on_attach = lsp_attach,
--	capabilities = Capabilities,

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

--})
