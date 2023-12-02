local lspconfig = require('lspconfig')

vim.keymap.set('n', '<Leader>dd', vim.diagnostic.open_float)
-- TODO other diagnostics, errors, repairs, info...

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

    -- Am i stupid, or this and nil_ls both do almost nothing
    -- where is my completion
    'nixd',

	'julials',
	'zls',
	'scheme_langserver',
    'hls', -- TODO C memory

    'texlab',
    'racket_langserver',
    'sqlls',

	'tsserver',

    -- Somehow works for now
    'nimls',
	-- This leaves nimsuggest instances running after closing editor
	-- At least on simple projects with only .nim files
	--'nim_langserver',
    -- For now it is added manually later

    --'java_language_server',
    -- or
    'jdtls',

    --'perlls',
    -- or
    --'perlpls',
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

-- lspconfig.nil_ls.setup({
--         preselectSupport = false,
--         preselect = false,
--         single_file_support = true,
--         on_attach = lsp_attach,
--         capabilities = Capabilities,
-- 
--         settings = {
--             ["nil_ls"] = {
--                 nixpkgsInputName = "nixos",
--             }
--         }
--     })
