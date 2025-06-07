-- helpers {{{

local lspconfig = require("lspconfig")
-- of course shit won't work because why would it
-- all of this fucking useless shit was created only
-- to show off with emptiness of heads of creators
-- i will switch to vscode at that rate of fucking
-- waterfall of messages that cannot be stopped
lspconfig.util.default_config = vim.tbl_extend(
  "force", lspconfig.util.default_config, { message_level = nil }
)

Lspfmt_files = {
  go = true,
  julia = true,
  zig = true,
  sh = true,
  html = "superhtml",
  elixir = true,
}
local lspfmt_get_gid
do
  local lspfmt_gid = 0
  lspfmt_get_gid = function()
    lspfmt_gid = lspfmt_gid + 1
    return lspfmt_gid
  end
end

if vim.fn.has("nvim-0.11") == 1 then
  function NvimDiagPrev()
    vim.diagnostic.jump({ count = -1, float = true })
  end

  function NvimDiagNext()
    vim.diagnostic.jump({ count = 1, float = true })
  end
else
  ---@diagnostic disable-next-line: deprecated
  function NvimDiagNext() vim.diagnostic.goto_next() end

  ---@diagnostic disable-next-line: deprecated
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
  "n", "<Leader>dqi", ":<C-u>LspInfo<CR>", { noremap = true }
)

vim.keymap.set(
  "n", "<Leader>dql", ":<C-u>LspLog<CR>", { noremap = true }
)

vim.keymap.set(
  "n", "<Leader>dqr", ":<C-u>LspRestart<CR>", { noremap = true }
)

vim.keymap.set(
  "n", "<Leader>dqs", ":<C-u>LspStart<CR>", { noremap = true }
)
vim.keymap.set(
  "n", "<Leader>dqe", ":<C-u>LspStop ", { noremap = true }
)
vim.keymap.set(
  "n", "<Leader>dqE", ":<C-u>LspStop *<CR>", { noremap = true }
)

-- }}}

-- general maps {{{

vim.keymap.set(
  "n", "<Leader>de", vim.diagnostic.open_float,
  { noremap = true, desc = "show diagnostics under cursor" }
)
vim.keymap.set(
  "n", "<Leader>dp", commandRep(NvimDiagPrev),
  { noremap = true, desc = "[N] prev diagnostic" }
)
vim.keymap.set(
  "n", "<Leader>dn", commandRep(NvimDiagNext),
  { noremap = true, desc = "[N] next diagnostic" }
)

vim.keymap.set(
  "n", "<Leader>dll", function(_)
    if vim.g.qfloc == 1 then
      vim.diagnostic.setloclist({ open = true })
    else
      vim.diagnostic.setqflist({ open = true })
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
      local opts = { buffer = bufnr, noremap = true }
      local tab_mod = "<C-w>"

      -- }}}

      -- info {{{

      vim.keymap.set(
        "n", "<Leader>dd", vim.lsp.buf.definition,
        add_opts(opts, { desc = "go to definition" })
      )
      vim.keymap.set(
        "n", tab_mod .. "<Leader>dd",
        "<cmd>tab split | lua vim.lsp.buf.definition()<CR>",
        add_opts(opts, { desc = "go to definition in new tab" })
      )

      vim.keymap.set(
        "n", "<Leader>dD", vim.lsp.buf.declaration,
        add_opts(opts, { desc = "go to declaration" })
      )
      vim.keymap.set(
        "n", tab_mod .. "<Leader>dD",
        "<cmd>tab split | lua vim.lsp.buf.declaration()<CR>",
        add_opts(opts, { desc = "go to declaration in new tab" })
      )

      vim.keymap.set(
        "n", "<Leader>di", vim.lsp.buf.implementation,
        add_opts(opts, { desc = "go to implementation" })
      )
      vim.keymap.set(
        "n", tab_mod .. "<Leader>di",
        "<cmd>tab split | lua vim.lsp.buf.implementation()<CR>",
        add_opts(
          opts, { desc = "go to implementation in new tab" }
        )
      )

      vim.keymap.set(
        "n", "<Leader>dt", vim.lsp.buf.type_definition,
        add_opts(opts, { desc = "go to type definition" })
      )
      vim.keymap.set(
        "n", tab_mod .. "<Leader>dt",
        "<cmd>tab split | lua vim.lsp.buf.type_definition()<CR>",
        add_opts(
          opts, { desc = "go to type definition in new tab" }
        )
      )

      vim.keymap.set(
        "n", "<Leader>ds", vim.lsp.buf.signature_help,
        add_opts(opts, { desc = "show signature help" })
      )

      vim.keymap.set(
        "n", "<Leader>dlr", function()
          vim.lsp.buf.references(nil, { loclist = vim.g.qfloc })
        end, add_opts(
          opts,
          { desc = "populate quickfix/loclist with references" }
        )
      )

      -- TODO qfloc
      vim.keymap.set(
        "n", "<Leader>dlu",
        function() vim.lsp.buf.typehierarchy("subtypes") end,
        add_opts(
          opts, { desc = "populate quickfix with subtypes" }
        )
      )
      vim.keymap.set(
        "n", "<Leader>dlo",
        function()
          vim.lsp.buf.typehierarchy("supertypes")
        end, add_opts(
          opts, { desc = "populate quickfix with supertypes" }
        )
      )

      vim.keymap.set(
        "n", "<Leader>dh", vim.lsp.buf.hover, add_opts(
          opts, {
            desc = "display hover information about the symbol under the cursor",
          }
        )
      )

      -- }}}

      -- actions {{{
      vim.keymap.set(
        "n", "<Leader>dr", vim.lsp.buf.rename,
        add_opts(opts, { desc = "rename symbol under cursor" })
      )
      vim.keymap.set(
        "n", "<Leader>df",
        function()
          vim.lsp.buf.format({ async = false })
          vim.cmd.norm("zv")
        end,
        add_opts(opts, { desc = "format file using lsp" })
      )

      vim.keymap.set(
        "n", "<Leader>da", vim.lsp.buf.code_action,
        add_opts(opts, { desc = "execute code action" })
      )
      -- }}}

      -- insert mode {{{

      -- Rather useless
      vim.keymap
          .set({ "i" }, "<C-x><C-q>", vim.lsp.buf.hover, opts)
      vim.keymap.set({ "i" }, "<C-x>q", "<C-x>q", opts)
      vim.keymap.set(
        { "i" }, "<C-x>;", vim.lsp.buf.signature_help, opts
      )

      --  }}}

      -- workspaces {{{
      vim.keymap.set(
        "n", "<Leader>dwa", vim.lsp.buf.add_workspace_folder,
        add_opts(opts, { desc = "add workspace folder" })
      )
      vim.keymap.set(
        "n", "<Leader>dwr", vim.lsp.buf.remove_workspace_folder,
        add_opts(opts, { desc = "remove workspace folder" })
      )
      vim.keymap.set(
        "n", "<Leader>dwl", function()
          print(
            vim.inspect(vim.lsp.buf.list_workspace_folders())
          )
        end, add_opts(opts, { desc = "list workspace folders" })
      )
      -- }}}

      -- formatting {{{

      -- when attaching first lsp define variable that will control
      -- formating on saving using lsp(s)
      local ftype = vim.api.nvim_get_option_value(
        "filetype", { scope = "local" }
      )

      local name = vim.lsp.get_client_by_id(args.data.client_id).name
      if Lspfmt_files[ftype] == true or Lspfmt_files[ftype] == name then
        vim.b.lspfmt = GetBool(vim.b.buffmt)
        vim.b.buffmt = false
        vim.keymap.set("n", "<Leader>dqf", function()
          vim.b.lspfmt = not vim.b.lspfmt
          print(vim.b.lspfmt)
        end)

        local lspfmt_gid = vim.api.nvim_create_augroup(
          "lspfmt_" .. lspfmt_get_gid(), {}
        )

        vim.api.nvim_create_autocmd(
          "BufWritePre", {
            buffer = 0,
            group = lspfmt_gid,
            callback = function(_)
              if vim.b.lspfmt then
                vim.lsp.buf.format()
              end
            end,
          }
        )

        -- turn off formatting enabled in lspconfig
        -- when lsp exits
        vim.api.nvim_create_autocmd(
          { "LspDetach" }, {
            buffer = 0,
            callback = function()
              vim.b.buffmt = GetBool(vim.b.lspfmt)
              vim.b.lspfmt = false
              vim.keymap.del("n", "<Leader>dqf")
              vim.api.nvim_del_augroup_by_id(lspfmt_gid)
            end
            ,
          }
        )
      end

      -- }}}
    end,
  }
) -- }}}
