-- helpers {{{
---@diagnostic disable: undefined-global
local lspconfig = require("lspconfig")
-- of course shit won't work because why would it
-- all of this fucking useless shit was created only
-- to show off with emptiness of heads of creators
-- i will switch to vscode at that rate of fucking
-- waterfall of messages that cannot be stopped
lspconfig.util.default_config = vim.tbl_extend(
  "force", lspconfig.util.default_config,
  { message_level = nil }
)

local diag_modes = { "n" }
local buf_modes = { "n" }

Lfiles = {
  go = true,
  julia = true,
  zig = true,
  sh = true,
  html = true,
  elixir = true,
}

-- }}}

-- commands {{{

vim.keymap.set(
  buf_modes, "<Leader>dqi", ":<C-u>LspInfo<CR>",
  { noremap = true }
)

vim.keymap.set(
  buf_modes, "<Leader>dql", ":<C-u>LspLog<CR>",
  { noremap = true }
)

vim.keymap.set(
  buf_modes, "<Leader>dqr", ":<C-u>LspRestart<CR>",
  { noremap = true }
)

vim.keymap.set(
  buf_modes, "<Leader>dqs", ":<C-u>LspStart<CR>",
  { noremap = true }
)
vim.keymap.set(
  buf_modes, "<Leader>dqe", ":<C-u>LspStop ", { noremap = true }
)
vim.keymap.set(
  buf_modes, "<Leader>dqE", ":<C-u>LspStop *<CR>",
  { noremap = true }
)

-- }}}

-- general maps {{{

vim.keymap.set(
  diag_modes, "<Leader>df", vim.diagnostic.open_float,
  { noremap = true }
)
vim.keymap.set(
  diag_modes, "<Leader>dp", commandRep(
    function()
      vim.diagnostic.jump({ count = -1, float = true })
    end
  ), { noremap = true }
)
vim.keymap.set(
  diag_modes, "<Leader>dn", commandRep(
    function()
      vim.diagnostic.jump({ count = 1, float = true })
    end
  ), { noremap = true }
)

vim.keymap.set(
  diag_modes, "<Leader>dl", function(_)
    if vim.g["qfloc"] == 1 then
      vim.diagnostic.setloclist({ open = true })
    else
      vim.diagnostic.setqflist({ open = true })
    end
  end, { noremap = true }
)

vim.keymap.set(
  buf_modes, "<Leader>dL", function(_)
    if vim.g["qfloc"] == 1 then
      vim.diagnostic.setloclist({ open = false })
    else
      vim.diagnostic.setqflist({ open = false })
    end
  end, { noremap = true }
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
        buf_modes, "<Leader>dd", vim.lsp.buf.definition, opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>dd",
        "<cmd>tab split | lua vim.lsp.buf.definition()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>dD", vim.lsp.buf.declaration, opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>dD",
        "<cmd>tab split | lua vim.lsp.buf.declaration()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>di", vim.lsp.buf.implementation,
        opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>di",
        "<cmd>tab split | lua vim.lsp.buf.implementation()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>dt", vim.lsp.buf.type_definition,
        opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>dt",
        "<cmd>tab split | lua vim.lsp.buf.type_definition()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>ds", vim.lsp.buf.signature_help,
        opts
      )
      vim.keymap.set(
        buf_modes, tab_mod .. "<Leader>ds",
        "<cmd>tab split | lua vim.lsp.buf.signature_help()<CR>",
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>dr", vim.lsp.buf.references, opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>dh", vim.lsp.buf.hover, opts
      )

      -- }}}

      -- actions {{{
      vim.keymap.set(
        buf_modes, "<Leader>dR", vim.lsp.buf.rename, opts
      )
      vim.keymap.set(
        buf_modes, "<Leader>dF",
        function() vim.lsp.buf.format({ async = true }) end,
        opts
      )

      vim.keymap.set(
        buf_modes, "<Leader>da", vim.lsp.buf.code_action, opts
      )
      -- }}}

      -- insert mode {{{

      -- Rather useless
      vim.keymap.set({ "i" }, "<C-x>;", vim.lsp.buf.hover, opts)

      --  }}}

      -- workspaces {{{
      vim.keymap.set(
        buf_modes, "<Leader>dwa",
        vim.lsp.buf.add_workspace_folder, opts
      )
      vim.keymap.set(
        buf_modes, "<Leader>dwr",
        vim.lsp.buf.remove_workspace_folder, opts
      )
      vim.keymap.set(
        buf_modes, "<Leader>dwl", function()
          print(
            vim.inspect(vim.lsp.buf.list_workspace_folders())
          )
        end, opts
      )
      -- }}}

      -- formatting {{{

      -- when attaching first lsp define variable that will control
      -- formating on saving using lsp(s)
      local ftype = vim.api.nvim_get_option_value(
        "filetype", { scope = "local" }
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
          "lspformat", { clear = true }
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
