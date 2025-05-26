-- editorconfig {{{
-- Proper editorconfig handling
vim.g.editorconfig = false
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufReadPre"}, {
    pattern = {"*"},
    ---@diagnostic disable-next-line: unused-local
    callback = function(ev)
      vim.b.editorconfig = vim.g.editorconfig
    end,
  }
)

vim.keymap.set(
  {"n", "v"}, "<Leader>qeg",
  ":let g:editorconfig=!g:editorconfig<CR>"
)
vim.keymap.set(
  {"n", "v"}, "<Leader>qeb",
  ":let b:editorconfig=!b:editorconfig<CR>"
)
-- Totally amateur
vim.keymap.set(
  {"n", "v"}, "<Leader>qer", "<Leader>qeb<Leader>qeb"
)

-- }}}

-- settings {{{

vim.api.nvim_create_autocmd(
  {"BufEnter"}, {
    pattern = {"*/.config/nvim*/*.lua"},
    ---@diagnostic disable-next-line: unused-local
    callback = function(ev)
      vim.cmd("setlocal keywordprg=':help'")
    end,
  }
)

-- Because neovim (treesitter) somehow get this fucked
vim.api.nvim_create_autocmd(
  {"BufRead"}, {
    pattern = {"*/doc/*.txt"},
    callback = function()
      vim.bo.filetype = "help"
      vim.bo.syntax = "help"
    end,
  }
)

-- }}}

-- keymaps {{{

vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", {remap = true})
vim.keymap.set("t", "<C-q><C-w>", "<C-w>", {noremap = true})
vim.keymap.set("t", "<C-q><C-q>", "<C-q>", {noremap = true})
vim.keymap.set(
  "t", "<C-q><C-n>", "<C-\\><C-n>", {noremap = true}
)
vim.keymap.set(
  "t", "<C-q><C-o>", "<C-\\><C-o>", {noremap = true}
)

-- }}}

-- colors {{{

vim.cmd.colorscheme("elflord")
vim.cmd.highlight("CursorLine", "guibg=#2a2a2a")

-- TODO C why is this reset after vim config
vim.cmd(
  [[
hi DiffAdd
            \ ctermbg=DarkGreen guibg=#0d5826
            \ ctermfg=NONE guifg=NONE
hi DiffText
            \ ctermbg=Gray guibg=#566670
            \ ctermfg=NONE guifg=NONE
hi DiffChange
            \ ctermbg=DarkBlue guibg=#0f1a7f
            \ ctermfg=NONE guifg=NONE
hi DiffDelete
            \ ctermbg=DarkRed guibg=#800620
            \ ctermfg=NONE guifg=NONE

hi Added ctermfg=10 guifg=LimeGreen
hi Removed ctermfg=9 guifg=Red
]]
)

vim.g.java_ignore_markdown = true

-- }}}

-- vim-slime {{{
vim.api.nvim_create_user_command(
  "SlimeConfigAll", function(opts)
    vim.cmd.SlimeConfig()
    vim.g.slime_default_config = vim.b.slime_config
  end, {nargs = 0}
)
vim.keymap.set(
  "n", "gs:", ":<C-u>SlimeConfigAll<CR>", {noremap = true}
)

function slime_setup_tmux()
  local function slime_tmux_uniform_config()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      local has, _ = pcall(
        vim.api.nvim_buf_get_var, bufnr, "slime_config"
      )
      if has then
        vim.api.nvim_buf_set_var(
          bufnr, "slime_config", vim.g.slime_default_config
        )
      end
    end
  end

  vim.api.nvim_create_user_command(
    "SlimeTmuxPane", function(opts)
      vim.g.slime_default_config = {
        socket_name = vim.g.slime_default_config.socket_name,
        target_pane = opts.fargs[1],
      }
      slime_tmux_uniform_config()
    end, {nargs = 1}
  )
  vim.api.nvim_create_user_command(
    "SlimeTmuxSocket", function(opts)
      vim.g.slime_default_config = {
        socket_name = opts.fargs[1],
        target_pane = vim.g.slime_default_config.target_pane,
      }
      slime_tmux_uniform_config()
    end, {nargs = 1}
  )

  vim.fn.SlimeSetupTmux()
end

function slime_setup_nvim()
  vim.g.slime_target = "neovim"
  vim.g.slime_suggest_default = false
  vim.g.slime_menu_config = false
  vim.g.slime_input_pid = false

  -- https://github.com/jpalardy/vim-slime/blob/main/assets/doc/targets/neovim.md
  vim.g.slime_get_jobid = function()
    -- iterate over all buffers to find the first terminal with a valid job
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_get_option_value("buftype", {buf = bufnr}) ==
        "terminal" then
        local chan = vim.api.nvim_get_option_value(
          "channel", {buf = bufnr}
        )
        if chan and chan > 0 then return chan end
      end
    end
    return nil
  end

  -- TODO is there a better way?
  pcall(vim.api.nvim_del_augroup_by_name, "SlimeConfig")
  vim.api.nvim_create_autocmd(
    "TermEnter", {
      group = vim.api.nvim_create_augroup("SlimeConfig", {}),
      -- Imperfect and brittle solution
      callback = function(args)
        -- for k, v in pairs(args) do print(k, " ", v) end
        pcall(vim.cmd.SlimeConfigAll)
      end,
    }
  )

  pcall(vim.api.nvim_del_user_command, "SlimeTmuxPane")
  pcall(vim.api.nvim_del_user_command, "SlimeTmuxSocket")
end

if vim.env.TMUX then
  slime_setup_tmux()
else
  slime_setup_nvim()
end

--  }}}

if vim.g.neovide then -- {{{

  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_cursor_hack = false
  vim.g.neovide_scale_factor = 0.95

  --  }}}
elseif vim.fn.has("gui_running") then --  {{{

  -- for uniform experience
  -- "t", "i" don't work anyway
  for _, mode in pairs({"n", "o", "v"}) do
    vim.keymap.set(mode, "<C-/>", "<C-_>", {})
  end

end --  }}}
