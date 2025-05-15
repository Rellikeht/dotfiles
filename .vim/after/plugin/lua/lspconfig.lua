-- helpers {{{
---@diagnostic disable: undefined-global
local lspconfig = require("lspconfig")
-- of course shit won't work because why would it
-- all of this fucking useless shit was created only
-- to show off with emptiness of heads of creators
-- i will switch to vscode at that rate of fucking
-- waterfall of messages that cannot be stopped
lspconfig.util.default_config = vim.tbl_extend(
  "force", lspconfig.util.default_config, {message_level = nil}
)

Lfiles = {
  go = true,
  julia = true,
  zig = true,
  sh = true,
  html = true,
  elixir = true,
}

if vim.fn.has("nvim-0.11") == 1 then
  function NvimDiagPrev()
    vim.diagnostic.jump({count = -1, float = true})
  end
  function NvimDiagNext()
    vim.diagnostic.jump({count = 1, float = true})
  end
else
  function NvimDiagNext() vim.diagnostic.goto_next() end
  function NvimDiagPrev() vim.diagnostic.goto_prev() end
end

local function add_opts(table, opts)
  local result = {}
  for k, v in pairs(table) do result[k] = v end
  for k, v in pairs(opts) do result[k] = v end
  return result
end

-- }}}

-- commands {{{

vim.keymap.set(
  "n", "<Leader>dqi", ":<C-u>LspInfo<CR>", {noremap = true}
)

vim.keymap.set(
  "n", "<Leader>dql", ":<C-u>LspLog<CR>", {noremap = true}
)

vim.keymap.set(
  "n", "<Leader>dqr", ":<C-u>LspRestart<CR>", {noremap = true}
)

vim.keymap.set(
  "n", "<Leader>dqs", ":<C-u>LspStart<CR>", {noremap = true}
)
vim.keymap.set(
  "n", "<Leader>dqe", ":<C-u>LspStop ", {noremap = true}
)
vim.keymap.set(
  "n", "<Leader>dqE", ":<C-u>LspStop *<CR>", {noremap = true}
)

-- }}}

-- general maps {{{

vim.keymap.set(
  "n", "<Leader>de", vim.diagnostic.open_float,
  {noremap = true, desc = "show diagnostics under cursor"}
)
vim.keymap.set(
  "n", "<Leader>dp", commandRep(NvimDiagPrev),
  {noremap = true, desc = "[N] prev diagnostic"}
)
vim.keymap.set(
  "n", "<Leader>dn", commandRep(NvimDiagNext),
  {noremap = true, desc = "[N] next diagnostic"}
)

vim.keymap.set(
  "n", "<Leader>dll", function(_)
    if vim.g.qfloc == 1 then
      vim.diagnostic.setloclist({open = true})
    else
      vim.diagnostic.setqflist({open = true})
    end
  end, {
    noremap = true,
    desc = "populate quickfix/loclist with diagnostics",
  }
)

-- }}}

vim.api.nvim_create_autocmd( -- {{{
  "LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
      -- helpers {{{

      local bufnr = args.buf
      local client = vim.lsp
                       .get_client_by_id(args.data.client_id)
      if client and
        client.server_capabilities.completionProvider then
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      end
      if client and
        client.server_capabilities.definitionProvider then
        vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
      end

      -- :help vim.lsp.*
      local opts = {buffer = bufnr, noremap = true}
      local tab_mod = "<C-w>"

      -- }}}

      -- info {{{

      vim.keymap.set(
        "n", "<Leader>dgd", vim.lsp.buf.definition,
        add_opts(opts, {desc = "go to definition"})
      )
      vim.keymap.set(
        "n", tab_mod .. "<Leader>dgd",
        "<cmd>tab split | lua vim.lsp.buf.definition()<CR>",
        add_opts(opts, {desc = "go to definition in new tab"})
      )

      vim.keymap.set(
        "n", "<Leader>dgD", vim.lsp.buf.declaration,
        add_opts(opts, {desc = "go to declaration"})
      )
      vim.keymap.set(
        "n", tab_mod .. "<Leader>dgD",
        "<cmd>tab split | lua vim.lsp.buf.declaration()<CR>",
        add_opts(opts, {desc = "go to declaration in new tab"})
      )

      vim.keymap.set(
        "n", "<Leader>dgi", vim.lsp.buf.implementation,
        add_opts(opts, {desc = "go to implementation"})
      )
      vim.keymap.set(
        "n", tab_mod .. "<Leader>dgi",
        "<cmd>tab split | lua vim.lsp.buf.implementation()<CR>",
        add_opts(
          opts, {desc = "go to implementation in new tab"}
        )
      )

      vim.keymap.set(
        "n", "<Leader>dgt", vim.lsp.buf.type_definition,
        add_opts(opts, {desc = "go to type definition"})
      )
      vim.keymap.set(
        "n", tab_mod .. "<Leader>dgt",
        "<cmd>tab split | lua vim.lsp.buf.type_definition()<CR>",
        add_opts(
          opts, {desc = "go to type definition in new tab"}
        )
      )

      vim.keymap.set(
        "n", "<Leader>dit", vim.lsp.buf.signature_help,
        add_opts(opts, {desc = "show signature help"})
      )

      vim.keymap.set(
        "n", "<Leader>dlr", function()
          vim.lsp.buf.references(nil, {loclist = vim.g.qfloc})
        end, add_opts(
          opts,
          {desc = "populate quickfix/loclist with references"}
        )
      )

      -- TODO qfloc
      vim.keymap.set(
        "n", "<Leader>dlu",
        function() vim.lsp.buf.typehierarchy("subtypes") end,
        add_opts(
          opts, {desc = "populate quickfix with subtypes"}
        )
      )
      vim.keymap.set(
        "n", "<Leader>dlo",
        function()
          vim.lsp.buf.typehierarchy("supertypes")
        end, add_opts(
          opts, {desc = "populate quickfix with supertypes"}
        )
      )

      vim.keymap.set(
        "n", "<Leader>dis", vim.lsp.buf.hover, add_opts(
          opts, {
            desc = "display hover information about the symbol under the cursor",
          }
        )
      )

      -- }}}

      -- actions {{{
      vim.keymap.set(
        "n", "<Leader>dar", vim.lsp.buf.rename,
        add_opts(opts, {desc = "rename symbol under cursor"})
      )
      vim.keymap.set(
        "n", "<Leader>daf",
        function() vim.lsp.buf.format({async = true}) end,
        add_opts(opts, {desc = "format file using lsp"})
      )

      vim.keymap.set(
        "n", "<Leader>daa", vim.lsp.buf.code_action,
        add_opts(opts, {desc = "execute code action"})
      )
      -- }}}

      -- insert mode {{{

      -- Rather useless
      vim.keymap.set({"i"}, "<C-x>;", vim.lsp.buf.hover, opts)

      --  }}}

      -- workspaces {{{
      vim.keymap.set(
        "n", "<Leader>dwa", vim.lsp.buf.add_workspace_folder,
        add_opts(opts, {desc = "add workspace folder"})
      )
      vim.keymap.set(
        "n", "<Leader>dwr", vim.lsp.buf.remove_workspace_folder,
        add_opts(opts, {desc = "remove workspace folder"})
      )
      vim.keymap.set(
        "n", "<Leader>dwl", function()
          print(
            vim.inspect(vim.lsp.buf.list_workspace_folders())
          )
        end, add_opts(opts, {desc = "list workspace folders"})
      )
      -- }}}

      -- formatting {{{

      -- when attaching first lsp define variable that will control
      -- formating on saving using lsp(s)
      local ftype = vim.api.nvim_get_option_value(
        "filetype", {scope = "local"}
      )
      -- TODO name
      if Lfiles[ftype] ~= nil then
        vim.cmd(
          [[
        let b:lspfmt = b:buffmt
        let b:buffmt = 0

        noremap <Leader>dqf :let b:lspfmt = !b:lspfmt<CR>:echo b:lspfmt<CR>
        ]]
        )

        local lspformat = vim.api.nvim_create_augroup(
          "lspformat", {clear = true}
        )

        vim.api.nvim_create_autocmd(
          "BufWritePre", {
            buffer = 0,
            callback = function(_)
              if vim.b["lspfmt"] == 1 then
                vim.lsp.buf.format()
              end
            end,
            group = lspformat,
          }
        )
      end

      -- }}}
    end,
  }
) -- }}}
