-- vim-slime {{{
vim.api.nvim_create_user_command(
  "SlimeConfigAll", function(opts)
    vim.cmd.SlimeConfig()
    vim.g.slime_default_config = vim.b.slime_config
  end, {nargs = 0}
)
vim.api.nvim_set_keymap(
  "n", "gs:", ":<C-u>SlimeConfigAll<CR>", {noremap = true}
)

local function slime_tmux_uniform_config()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    has, _ = pcall(
      vim.api.nvim_buf_get_var, bufnr, "slime_config"
    )
    if has then
      vim.api.nvim_buf_set_var(
        bufnr, "slime_config", vim.g.slime_default_config
      )
    end
  end
end

function slime_setup_tmux()
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

  -- TODO term command that generates config automagically

  vim.b.slime_config = vim.g.slime_default_config
  pcall(vim.api.nvim_del_augroup_by_name, "SlimeConfig")
  vim.api.nvim_create_autocmd(
    "BufNew", {
      group = vim.api.nvim_create_augroup("SlimeConfig", {}),
      callback = function(args)
        -- Very imperfect and brittle solution really
        pcall(vim.cmd.SlimeConfig)
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
